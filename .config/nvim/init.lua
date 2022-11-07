local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd('packadd packer.nvim')
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- general settings
  vim.keymap.set('i', 'kj', '<Esc>')
  vim.g.mapleader = ','
  vim.g.encoding = 'utf-8'

  -- indentations
  vim.opt.expandtab = true
  vim.opt.shiftwidth = 2

  -- line numbering: relative when focused, absolute otherwise
  vim.cmd('set signcolumn=yes')
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

  -- colors
  use 'edeneast/nightfox.nvim'
  vim.cmd('colorscheme nightfox')

  -- status bar
  use 'nvim-lualine/lualine.nvim'
  require('lualine').setup {
    options = {
      theme = 'nightfox'
    }
  }

  -- tabs and buffers
  use 'nanozuki/tabby.nvim'
  require('tabby').setup()

  -- file tree
  use {
    'nvim-neo-tree/neo-tree.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'muniftanjim/nui.nvim',
      'kyazdani42/nvim-web-devicons',
    }
  }
  require('neo-tree').setup()

  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = 'nvim-lua/plenary.nvim'
  }
  local telescope_builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
  vim.keymap.set('n', '<leader>fp', telescope_builtin.git_files, {})
  vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
  vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})

  -- end of config, bootstraping packer
  if packer_bootsrap then
    require('packer').sync()
  end
end)

