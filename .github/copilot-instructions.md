# Copilot Instructions For This Neovim Config

## Project Shape

- This repository is a Lua-first personal Neovim configuration.
- `init.lua` is intentionally tiny and just loads `require("config")`.
- Core editor behavior lives under `lua/config/`.
- Plugin specs and plugin-specific setup live under `lua/plugins/`.
- `README.md` documents the current user-facing behavior and must stay in sync
  with config changes.
- `.luarc.json` configures the Lua language server for this repo.
- `lazy-lock.json` is the Lazy lockfile and should only change when plugin
  versions are intentionally updated.

## Main Entry Points

- `lua/config/init.lua` loads the config modules in order:
  `options`, `keymaps`, `autocmds`, `lazy`, `theme`, and `statusline`.
- `lua/config/lazy.lua` bootstraps `lazy.nvim` and imports plugin specs from
  `lua/plugins/`.
- `lua/plugins/lsp.lua` owns completion, snippets, formatting, Mason, and native
  LSP setup.
- `lua/plugins/snacks.lua` owns Snacks picker, indent, scrolling, related
  keymaps, and helper user commands.
- `lua/plugins/alpha.lua` owns the start screen and its `F6` mapping.

## Editing Rules

- Prefer editing the Lua modules under `lua/config/` and `lua/plugins/`.
- Keep plugin configuration in the plugin file that owns that plugin.
- Avoid splitting one plugin across multiple spec files unless there is a very
  clear reason.
- Do not reintroduce old Vimscript-era config patterns when a Lua equivalent
  already exists.
- Do not modify vendored or legacy third-party code under `plugged/` or
  `autoload/plug.vim` unless the user explicitly asks for that.
- Preserve the VS Code compatibility checks controlled by `vim.g.vscode`.

## Codebase Conventions

- Keep the config minimal and avoid redundant plugins or overlapping features.
- Prefer built-in Neovim features when they already provide the needed behavior.
- Completion is handled by `blink.cmp`, not CoC or `nvim-cmp`.
- Formatting is handled by `conform.nvim`.
- LSP is handled by native Neovim LSP plus Mason and `mason-lspconfig`.
- Snippet completion comes from Blink with `friendly-snippets`.
- Picker workflows should use Snacks instead of reintroducing fzf-style plugin
  config.
- Global keymaps belong in `lua/config/keymaps.lua`.
- Buffer-local LSP keymaps belong in `lua/plugins/lsp.lua`.
- If a change affects documented behavior, update `README.md`.

## Verification

- After editing Lua files, prefer validating with headless Neovim or `luac -p`
  when practical.
- For mapping changes, mention the expected interactive check inside Neovim.
- For plugin spec changes, remember that a full Neovim restart is the safest
  way to apply them.

## When Assisting

- Optimize for simple, maintainable config rather than clever reload logic.
- Favor one clear source of truth per plugin or feature.
- Keep the README aligned with current mappings, commands, plugins, and setup.
- Treat stale files from the old Vimscript setup as historical leftovers unless
  the user explicitly wants to revive or migrate them.
