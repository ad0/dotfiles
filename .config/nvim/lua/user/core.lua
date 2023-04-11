-- general settings
vim.keymap.set('i', 'kj', '<Esc>')
vim.g.mapleader = ','
vim.g.encoding = 'utf-8'

-- indentations
vim.opt.expandtab = true
vim.opt.shiftwidth = 2

-- line numbering: relative when focused, absolute otherwise
vim.cmd('set number relativenumber')
local augroup = vim.api.nvim_create_augroup('numbertoggle', { clear = true })
vim.api.nvim_create_autocmd(
  { 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' },
  { group = augroup, pattern = '*', command = 'if &nu && mode() != "i" | set rnu | endif' }
)
vim.api.nvim_create_autocmd(
  { 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' },
  { group = augroup, pattern = '*', command = 'if &nu | set nornu | endif' }
)

-- highlight current line
vim.cmd('set cursorline')
