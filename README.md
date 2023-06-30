# nvim-pasta

The yank/paste enhancement plugin for neovim.

This plugin provides the following functionality.

1. Save your all yank history automatically.
2. Cycle yank history after paste via `config.next_key` and `config.prev_key`.
3. Adjust indentation for line-wise content's

## Usage

### Setup

```lua
vim.keymap.set({ 'n', 'x' }, 'p', require('pasta.mappings').p)
vim.keymap.set({ 'n', 'x' }, 'P', require('pasta.mappings').P)
vim.keymap.set({ 'n' }, '<C-p>', require('pasta.mappings').toggle_pin)

-- This is the default. You can omit `setup` call if you don't want to change this. 
require('pasta').setup {
  paste_mode = false,
  fix_cursor = true,
  fix_indent = true,
  prevent_diagnostics = false,
  next_key = vim.api.nvim_replace_termcodes('<C-p>', true, true, true),
  prev_key = vim.api.nvim_replace_termcodes('<C-n>', true, true, true),
}
require('pasta').setup.filetype({ 'markdown', 'yaml' },  {
  converters = {},
})
```

### Plan

- [x] Adjust indentation for line-wise paste
- [x] Improve macro handling
- [x] Support visual mode
- [ ] Preview next/prev candidates
