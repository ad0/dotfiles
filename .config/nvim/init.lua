require "user.plugins"


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

-- fuzzy finder
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fp', telescope_builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})

-- LSP and completion
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset,
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
  }),
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
lspconfig['sumneko_lua'].setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
lspconfig['rust_analyzer'].setup {}
lspconfig['volar'].setup {
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
}
lspconfig['ocamllsp'].setup {}
lspconfig['hls'].setup {}

local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = false,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "TelescopeBorder" })
vim.cmd([[
hi DiagnosticUnderlineError cterm=underline gui=underline
hi DiagnosticUnderlineWarn cterm=underline gui=underline
hi DiagnosticUnderlineInfo cterm=underline gui=underline
hi DiagnosticUnderlineHint cterm=underline gui=underline
]])
vim.o.updatetime = 250
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

require("trouble").setup()
