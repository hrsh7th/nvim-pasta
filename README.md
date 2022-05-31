# nvim-pasta

The yank/paste enhancement plugin for neovim.

(Early stage.)


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
