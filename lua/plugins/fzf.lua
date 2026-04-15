return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "nvim-mini/mini.icons" },
  opts = {},
  config = function()
    local fzf = require("fzf-lua")
    local config = require("fzf-lua.config")
    local make_entry = require("fzf-lua.make_entry")
    local utils = require("fzf-lua.utils")

    fzf.setup({})

    local jj_status_badges = {
      A = utils.ansi_codes.green("A"),
      C = utils.ansi_codes.magenta("C"),
      D = utils.ansi_codes.red("D"),
      M = utils.ansi_codes.yellow("M"),
      R = utils.ansi_codes.blue("R"),
    }

    local function parse_jj_status_line(line)
      local status, rest = line:match("^(%u)%s+(.+)$")
      if not status then
        return nil
      end

      if status == "R" then
        local old_path, new_path = rest:match("^(.-)%s+=>%s+(.+)$")
        if old_path and new_path then
          return {
            status = status,
            old_path = old_path,
            path = new_path,
          }
        end
      end

      return {
        status = status,
        path = rest,
      }
    end

    local function run_jj(args, cwd)
      local result = vim.system(args, { cwd = cwd, text = true }):wait()
      if result.code ~= 0 then
        local err = vim.trim(result.stderr or "")
        if err == "" then
          err = vim.trim(result.stdout or "")
        end
        return nil, err
      end

      local output = vim.trim(result.stdout or "")
      if output == "" then
        return {}
      end

      return vim.split(output, "\n", { trimempty = true })
    end

    local function resolve_jj_root()
      local current_file = vim.api.nvim_buf_get_name(0)
      local search_dirs = {
        #current_file > 0 and vim.fn.fnamemodify(current_file, ':p:h') or nil,
        vim.fn.getcwd(),
      }

      for _, dir in ipairs(search_dirs) do
        if dir and dir ~= "" then
          local output, err = run_jj({ "jj", "root", "--ignore-working-copy" }, dir)
          if output and output[1] then
            return output[1]
          end
          if err and err ~= "" and not err:match("There is no jj repo") then
            vim.notify(err, vim.log.levels.WARN)
            return nil
          end
        end
      end
    end

    vim.keymap.set('n', '<leader>ff', fzf.files, {})
    vim.keymap.set('n', '<leader>fb', fzf.buffers, {})
    vim.keymap.set('n', '<leader>fh', fzf.oldfiles, {})
    vim.keymap.set('n', '<leader>fg', fzf.grep, {})
    vim.keymap.set('n', '<leader>fq', fzf.quickfix, {})
    vim.keymap.set('n', '<leader>fs', fzf.lsp_document_symbols, {})
    vim.keymap.set('n', '<leader>fman', fzf.manpages, {})
    vim.keymap.set('n', '<leader>frr', fzf.registers, {})
    -- vim.keymap.set('n', '<leader>fgg', fzf.git_status, {})

    vim.keymap.set('n', '<leader>fjj', function()
      local cwd = resolve_jj_root()
      if not cwd then
        vim.notify("Not inside a jj repo", vim.log.levels.WARN)
        return
      end

      local lines, err = run_jj({ "jj", "diff", "--summary", "--quiet" }, cwd)
      if not lines then
        vim.notify(err ~= "" and err or "Failed to read jj status", vim.log.levels.WARN)
        return
      end

      if vim.tbl_isempty(lines) then
        vim.notify("No jj changes found", vim.log.levels.INFO)
        return
      end

      local actions = vim.deepcopy(config.globals.actions.files or {})
      actions["alt-f"] = nil
      actions["alt-h"] = nil
      actions["alt-i"] = nil

      fzf.fzf_exec(lines, {
        cwd = cwd,
        prompt = "JJ Status> ",
        actions = actions,
        file_icons = true,
        color_icons = true,
        previewer = config.globals.files.previewer,
        winopts = vim.deepcopy(config.globals.files.winopts),
        _type = "file",
        _headers = { "actions", "cwd" },
        _fmt = {
          from = function(line)
            local parsed = parse_jj_status_line(line)
            return parsed and parsed.path or line
          end,
        },
        fn_transform = function(line, opts)
          local parsed = parse_jj_status_line(line)
          if not parsed then
            return
          end

          local badge = jj_status_badges[parsed.status] or parsed.status

          if parsed.old_path then
            local file = make_entry.file(parsed.path, opts)
            if not file then
              return
            end

            return table.concat({
              badge,
              utils.nbsp,
              parsed.old_path .. " ->",
              utils.nbsp,
              file,
            })
          end

          local file = make_entry.file(parsed.path, opts)
          if not file then
            return
          end

          return table.concat({ badge, utils.nbsp, file })
        end,
      })
    end, { desc = "JJ status files" })
  end,
}
