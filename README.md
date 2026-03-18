# Neovim Configuration

# Install Dependencies
```zsh
brew install Neovim
```

For TypeScript/JavaScript debugging support:

```zsh
brew install node
```

Then install language servers:

```zsh
brew install rust-analyzer python-lsp-server lua-language-server
```

# TypeScript Debugging

Debugging is Neovim-native (no `.vscode` folder required) and works with built-in DAP profiles.

1. Open Neovim and run `:Lazy sync` once.
1. Open `:Mason` and confirm `js-debug-adapter` is installed.
1. In a TypeScript/JavaScript buffer, start debugging with `Shift+F5` (use `fn` key on Mac keyboards if needed).

Available profiles include:

1. Single file debugging.
1. Server run via `package.json` script (preferred for project env).
1. Server launch from an entry file (direct fallback).
1. Attach to a running Node process.
1. Test run via `package.json` script (preferred for project env).
1. Direct Vitest/Jest current-file debug fallbacks.

Default debug keymaps:

1. `<leader>dd`: start/continue.
1. `<leader>db`: toggle breakpoint.
1. `<leader>di`: step into.
1. `<leader>dn`: step over.
1. `<leader>do`: step out.
1. `<leader>dq`: stop.
1. `<leader>du`: toggle debug UI.
1. `<leader>dr`: toggle DAP REPL.
1. `F9`: resume/start continue (IntelliJ style).
1. `F8`: step over.
1. `F7`: step into.
1. `Shift+F8`: step out.
1. `Ctrl+F8`: toggle breakpoint.
1. `Ctrl+F2`: stop.
1. `Shift+F11`: toggle debug UI.
1. `Alt+F8`: evaluate/REPL toggle.
