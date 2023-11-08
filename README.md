# nvim-pasta

The yank/paste enhancement plugin for neovim.

This plugin provides the following functionality.

1. Save your all yank history automatically.
2. Cycle yank history after paste via `config.next_key` and `config.prev_key`.

## Usage

### Setup

```lua
vim.keymap.set({ 'n', 'x' }, 'p', require('pasta.mapping').p)
vim.keymap.set({ 'n', 'x' }, 'P', require('pasta.mapping').P)

-- This is the default. You can omit `setup` call if you don't want to change this. 
require('pasta').config.next_key = vim.keycode('<C-n>')
require('pasta').config.prev_key = vim.keycode('<C-p>')
require('pasta').config.indent_key = vim.keycode(',')
require('pasta').config.indent_fix = true
```

### Plan

- [x] Adjust indentation for line-wise paste
- [x] Improve macro handling
- [x] Support visual mode
- [ ] Preview next/prev candidates

