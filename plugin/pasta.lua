if vim.g.loaded_pasta then
  return
end
vim.g.loaded_pasta = true

local pasta = require('pasta')

---Create autocmd.
local group = vim.api.nvim_create_augroup('pasta', {
  clear = true
})
vim.api.nvim_create_autocmd('TextYankPost', {
  group = group,
  callback = function()
    if vim.v.event.regname == '' or vim.v.event.regname == vim.v.register  then
      pasta.save(vim.v.event.regtype, vim.v.event.regcontents)
    end
  end
})

---Create highlights.
vim.api.nvim_set_hl(0, 'PastaCursor', {
  default = true,
  bg = 'Orange',
})

