local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local augroup = vim.api.nvim_create_augroup('packer_user_config', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = augroup,
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerUpdate'
})

local packer = require('packer')

packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'single' }
    end,
  },
}

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'nvim-lua/popup.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }

  use 'edeneast/nightfox.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'nanozuki/tabby.nvim'
  use {
    'nvim-neo-tree/neo-tree.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'muniftanjim/nui.nvim',
      'kyazdani42/nvim-web-devicons',
    }
  }
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = 'nvim-lua/plenary.nvim'
  }

  use 'neovim/nvim-lspconfig'   -- collection of common configurations for builtin LSP client
  use 'hrsh7th/nvim-cmp'        -- completion framework
  use 'hrsh7th/cmp-nvim-lsp'    -- LSP completion source
  use 'hrsh7th/cmp-path'        -- paths completion source
  use 'hrsh7th/cmp-vsnip'       -- snippet completion source
  use 'hrsh7th/vim-vsnip'       -- snippet framework

  -- bootstraping packer
  if packer_bootstrap then
    require('packer').sync()
  end
end)
