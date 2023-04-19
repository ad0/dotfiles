-- colors
vim.cmd('colorscheme nightfox')

-- status bar
require('lualine').setup {}

-- tabs and buffers
require('tabby').setup()

-- file tree
require('neo-tree').setup()

require('indent_blankline').setup {
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
}
