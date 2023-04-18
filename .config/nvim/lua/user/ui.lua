-- colors
vim.cmd('colorscheme nightfox')

-- status bar
require('lualine').setup {
  options = {
    theme = 'nightfox'
  }
}

-- tabs and buffers
require('tabby').setup()

-- file tree
require('neo-tree').setup()

require('indent_blankline').setup()
