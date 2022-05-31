# nvim-pasta

The yank/paste enhancement plugin for neovim.

This plugin provides the following functionality.

1. Save your all yank history automatically.
2. Cycle yank history after paste via `<C-n>` or `<C-p>` 
3. ~Adjust block-wise register content's indentation~ (in the future)

## Usage

### Add mapping

```lua
vim.keymap.set('n', 'p', '<Plug>(pasta-p)')
```


### Cycle keys

The current nvim-pasta hardcoded the keys for cycling the yank history.

Next: `<C-n>`
Prev: `<C-p>`


### Plan

- High
    - Adjust indentation for block-wise paste
    - Preview next/prev candidates
- Low
  - Listing and managing current yank history
