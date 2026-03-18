return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "williamboman/mason.nvim",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("mason").setup()

      local registry = require("mason-registry")
      if registry.has_package("js-debug-adapter") then
        local js_debug_adapter = registry.get_package("js-debug-adapter")
        if not js_debug_adapter:is_installed() then
          js_debug_adapter:install()
        end
      else
        vim.schedule(function()
          vim.notify("Mason package js-debug-adapter was not found in registry.", vim.log.levels.ERROR, {
            title = "nvim-dap",
          })
        end)
      end

      dapui.setup({
        controls = {
          enabled = false,
        },
      })
      require("nvim-dap-virtual-text").setup({})

      local uv = vim.uv or vim.loop

      local function project_root()
        local current_file = vim.api.nvim_buf_get_name(0)
        local start_path = current_file ~= "" and vim.fs.dirname(current_file) or uv.cwd()
        local markers = {
          ".git",
          "package.json",
          "tsconfig.json",
          "jsconfig.json",
          "pnpm-workspace.yaml",
        }

        local found = vim.fs.find(markers, { upward = true, path = start_path })[1]
        if found then
          return vim.fs.dirname(found)
        end

        return uv.cwd()
      end

      local function input_non_empty(prompt, default_value, completion)
        local value
        if completion ~= nil then
          value = vim.fn.input(prompt, default_value, completion)
        else
          value = vim.fn.input(prompt, default_value)
        end
        if value == "" then
          return default_value
        end
        return value
      end

      local debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
      if vim.fn.filereadable(debugger_path) == 0 then
        vim.schedule(function()
          vim.notify(
            "js-debug-adapter is still installing in Mason; TypeScript debugging will be available once install finishes.",
            vim.log.levels.WARN,
            { title = "nvim-dap" }
          )
        end)
      end

      local mason_adapter_bin = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter"
      if vim.fn.executable(mason_adapter_bin) == 0 then
        vim.schedule(function()
          vim.notify("js-debug-adapter launcher is missing from Mason bin; run :Mason and reinstall js-debug-adapter.", vim.log.levels.ERROR, {
            title = "nvim-dap",
          })
        end)
      end

      local function find_open_port()
        local tcp = uv.new_tcp()
        if not tcp then
          return nil, "failed to allocate tcp handle"
        end

        local ok, bind_err = tcp:bind("127.0.0.1", 0)
        if not ok then
          tcp:close()
          return nil, "failed to bind an ephemeral debug port: " .. tostring(bind_err)
        end

        local socket = tcp:getsockname()
        local port = socket and socket.port
        tcp:close()
        if type(port) ~= "number" then
          return nil, "failed to discover an open debug port"
        end

        return port, nil
      end

      local function find_lldb_dap_executable()
        local candidates = {
          vim.fn.exepath("lldb-dap"),
          "/opt/homebrew/opt/llvm/bin/lldb-dap",
          "/usr/local/opt/llvm/bin/lldb-dap",
        }

        for _, candidate in ipairs(candidates) do
          if candidate ~= nil and candidate ~= "" and vim.fn.executable(candidate) == 1 then
            return candidate
          end
        end

        return nil
      end

      dap.adapters["pwa-node"] = function(callback)
        local port, port_err = find_open_port()
        if not port then
          vim.notify(port_err, vim.log.levels.ERROR, {
            title = "nvim-dap",
          })
          return
        end

        callback({
          type = "server",
          host = "127.0.0.1",
          port = port,
          executable = {
            command = mason_adapter_bin,
            args = { tostring(port), "127.0.0.1" },
          },
        })
      end

      local lldb_dap_executable = find_lldb_dap_executable()
      if lldb_dap_executable then
        dap.adapters["lldb"] = {
          type = "executable",
          command = lldb_dap_executable,
          name = "lldb",
        }
      else
        vim.schedule(function()
          vim.notify("lldb-dap was not found in PATH. Install LLVM lldb-dap to enable Zig debugging.", vim.log.levels.WARN, {
            title = "nvim-dap",
          })
        end)
      end

      local function test_name_argument(label, flag)
        local test_name = vim.fn.input(label)
        if test_name == "" then
          return {}
        end
        return { flag, test_name }
      end

      local function project_binary_or_prompt(relative_path, label)
        local candidate = project_root() .. "/" .. relative_path
        if vim.fn.filereadable(candidate) == 1 then
          return candidate
        end

        vim.notify("Could not find " .. relative_path .. " in current project root.", vim.log.levels.WARN, {
          title = "nvim-dap",
        })
        return input_non_empty(label, candidate, "file")
      end

      local function current_file_or_default(default_file)
        local current_file = vim.api.nvim_buf_get_name(0)
        if current_file ~= "" then
          return current_file
        end
        return default_file
      end

      local function is_typescript_buffer()
        return vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact"
      end

      local function zig_project_root()
        local current_file = vim.api.nvim_buf_get_name(0)
        local start_path = current_file ~= "" and vim.fs.dirname(current_file) or uv.cwd()
        local markers = { "build.zig", ".git" }
        local found = vim.fs.find(markers, { upward = true, path = start_path })[1]
        if found then
          return vim.fs.dirname(found)
        end
        return uv.cwd()
      end

      local function zig_output_binary_path(source_file)
        local root = zig_project_root()
        local source_basename = vim.fn.fnamemodify(source_file, ":t:r")
        return root .. "/zig-out/bin/" .. source_basename
      end

      local function build_current_zig_file()
        local source_file = vim.api.nvim_buf_get_name(0)
        if source_file == "" then
          vim.notify("No current file to build for Zig debugging.", vim.log.levels.ERROR, { title = "nvim-dap" })
          return nil
        end

        if vim.fn.executable("zig") == 0 then
          vim.notify("zig executable was not found in PATH.", vim.log.levels.ERROR, { title = "nvim-dap" })
          return nil
        end

        local output_path = zig_output_binary_path(source_file)
        local output_dir = vim.fs.dirname(output_path)
        if vim.fn.isdirectory(output_dir) == 0 then
          local mkdir_ok = vim.fn.mkdir(output_dir, "p")
          if mkdir_ok == 0 then
            vim.notify("Failed to create Zig output directory: " .. output_dir, vim.log.levels.ERROR, {
              title = "nvim-dap",
            })
            return nil
          end
        end

        local result = vim.fn.system({ "zig", "build-exe", "-O", "Debug", "-femit-bin=" .. output_path, source_file })
        if vim.v.shell_error ~= 0 then
          vim.notify("zig build-exe failed:\n" .. result, vim.log.levels.ERROR, { title = "nvim-dap" })
          return input_non_empty("Build failed, binary to debug: ", output_path, "file")
        end

        if vim.fn.filereadable(output_path) == 0 then
          vim.notify("Zig build completed but binary was not found at " .. output_path, vim.log.levels.WARN, {
            title = "nvim-dap",
          })
          return input_non_empty("Binary to debug: ", output_path, "file")
        end

        return output_path
      end

      local function detect_package_manager(root)
        if vim.fn.filereadable(root .. "/pnpm-lock.yaml") == 1 then
          return "pnpm"
        end
        if vim.fn.filereadable(root .. "/yarn.lock") == 1 then
          return "yarn"
        end
        if vim.fn.filereadable(root .. "/bun.lockb") == 1 or vim.fn.filereadable(root .. "/bun.lock") == 1 then
          return "bun"
        end
        return "npm"
      end

      local function package_runner(root)
        local package_manager = detect_package_manager(root)
        if vim.fn.executable(package_manager) == 1 then
          return package_manager
        end

        if package_manager ~= "npm" and vim.fn.executable("npm") == 1 then
          vim.notify(package_manager .. " was not found in PATH, falling back to npm.", vim.log.levels.WARN, {
            title = "nvim-dap",
          })
          return "npm"
        end

        return package_manager
      end

      local function read_package_json_scripts(root)
        local package_json_path = root .. "/package.json"
        if vim.fn.filereadable(package_json_path) == 0 then
          return {}
        end

        local file_lines = vim.fn.readfile(package_json_path)
        local ok, decoded = pcall(vim.json.decode, table.concat(file_lines, "\n"))
        if not ok or type(decoded) ~= "table" then
          vim.notify("Could not parse package.json while preparing debug script run.", vim.log.levels.WARN, {
            title = "nvim-dap",
          })
          return {}
        end

        if type(decoded.scripts) == "table" then
          return decoded.scripts
        end

        return {}
      end

      local function choose_default_script(scripts, preferred, fallback)
        for _, script_name in ipairs(preferred) do
          if scripts[script_name] ~= nil then
            return script_name
          end
        end
        return fallback
      end

      local function split_shell_words(raw)
        if raw == "" then
          return {}
        end
        return vim.split(raw, " ", { trimempty = true })
      end

      local function package_script_runtime_args(prompt_label, preferred_scripts, fallback_script, extra_args_prompt, extra_args_default)
        return function()
          local root = project_root()
          local scripts = read_package_json_scripts(root)
          local default_script = choose_default_script(scripts, preferred_scripts, fallback_script)
          local script_name = input_non_empty(prompt_label, default_script)

          local runtime_args = { "run", script_name }
          local extra = input_non_empty(extra_args_prompt, extra_args_default)
          if extra ~= "" then
            table.insert(runtime_args, "--")
            vim.list_extend(runtime_args, split_shell_words(extra))
          end

          return runtime_args
        end
      end

      local javascript_like_filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
      }

      local shared_configs = {
        {
          type = "pwa-node",
          request = "launch",
          name = "File: Debug current file",
          cwd = project_root,
          program = "${file}",
          runtimeExecutable = function()
            if is_typescript_buffer() then
              return input_non_empty("Runtime executable for TS file: ", "npx")
            end
            return "node"
          end,
          runtimeArgs = function()
            if is_typescript_buffer() then
              local default = "tsx"
              local tool = input_non_empty("Runtime args before file (TS): ", default)
              return vim.split(tool, " ", { trimempty = true })
            end
            return {}
          end,
          sourceMaps = true,
          console = "integratedTerminal",
          skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Server: Run package.json script",
          cwd = project_root,
          runtimeExecutable = function()
            return package_runner(project_root())
          end,
          runtimeArgs = package_script_runtime_args(
            "Server script name: ",
            { "dev", "start", "serve", "server" },
            "dev",
            "Script args after -- (optional): ",
            ""
          ),
          sourceMaps = true,
          console = "integratedTerminal",
          skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Server: Launch from entry file",
          cwd = project_root,
          runtimeExecutable = function()
            if is_typescript_buffer() then
              return input_non_empty("Runtime executable for TS server: ", "npx")
            end
            return input_non_empty("Runtime executable: ", "node")
          end,
          runtimeArgs = function()
            if is_typescript_buffer() then
              local default = "tsx"
              local tool = input_non_empty("Runtime args before server file (TS): ", default)
              return vim.split(tool, " ", { trimempty = true })
            end
            return {}
          end,
          program = function()
            return input_non_empty("Server entry file: ", current_file_or_default("src/index.ts"), "file")
          end,
          args = function()
            local raw_args = vim.fn.input("Arguments (space-separated): ")
            if raw_args == "" then
              return {}
            end
            return vim.split(raw_args, " ", { trimempty = true })
          end,
          sourceMaps = true,
          console = "integratedTerminal",
          skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach: Pick Node process",
          cwd = project_root,
          processId = require("dap.utils").pick_process,
          skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Tests: Run package.json script",
          cwd = project_root,
          runtimeExecutable = function()
            return package_runner(project_root())
          end,
          runtimeArgs = package_script_runtime_args(
            "Test script name: ",
            { "test:debug", "test", "test:unit", "test:integration" },
            "test",
            "Test args after -- (default: current file): ",
            vim.fn.expand("%:p")
          ),
          console = "integratedTerminal",
          skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Tests: Debug current file (Vitest direct)",
          cwd = project_root,
          runtimeExecutable = "node",
          runtimeArgs = { "--inspect-brk" },
          program = function()
            return project_binary_or_prompt("node_modules/vitest/vitest.mjs", "Vitest entrypoint: ")
          end,
          args = function()
            local args = { "run", vim.fn.expand("%:p") }
            vim.list_extend(args, test_name_argument("Vitest test name (optional): ", "-t"))
            return args
          end,
          console = "integratedTerminal",
          skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Tests: Debug current file (Jest direct)",
          cwd = project_root,
          runtimeExecutable = "node",
          runtimeArgs = { "--inspect-brk" },
          program = function()
            return project_binary_or_prompt("node_modules/jest/bin/jest.js", "Jest entrypoint: ")
          end,
          args = function()
            local args = { vim.fn.expand("%:p"), "--runInBand" }
            vim.list_extend(args, test_name_argument("Jest test name (optional): ", "-t"))
            return args
          end,
          console = "integratedTerminal",
          skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
        },
      }

      for _, filetype in ipairs(javascript_like_filetypes) do
        dap.configurations[filetype] = vim.deepcopy(shared_configs)
      end

      if lldb_dap_executable then
        dap.configurations.zig = {
          {
            type = "lldb",
            request = "launch",
            name = "Zig: Build & debug current file",
            cwd = zig_project_root,
            program = function()
              return build_current_zig_file()
            end,
            args = function()
              local raw_args = vim.fn.input("Program args (space-separated): ")
              if raw_args == "" then
                return {}
              end
              return vim.split(raw_args, " ", { trimempty = true })
            end,
            stopOnEntry = false,
          },
          {
            type = "lldb",
            request = "launch",
            name = "Zig: Debug existing binary",
            cwd = zig_project_root,
            program = function()
              local source_file = vim.api.nvim_buf_get_name(0)
              local default_binary = source_file ~= "" and zig_output_binary_path(source_file) or zig_project_root() .. "/zig-out/bin/"
              return input_non_empty("Binary path: ", default_binary, "file")
            end,
            args = function()
              local raw_args = vim.fn.input("Program args (space-separated): ")
              if raw_args == "" then
                return {}
              end
              return vim.split(raw_args, " ", { trimempty = true })
            end,
            stopOnEntry = false,
          },
          {
            type = "lldb",
            request = "attach",
            name = "Zig: Attach to process",
            cwd = zig_project_root,
            pid = require("dap.utils").pick_process,
          },
        }
      end

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
    end,
  },
}
