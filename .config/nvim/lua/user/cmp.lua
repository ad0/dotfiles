local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
  }),
  window = {
    documentation = cmp.config.window.bordered()
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(
      { behavior = cmp.SelectBehavior.Select }
    ),
    ['<Down>'] = cmp.mapping.select_next_item(
      { behavior = cmp.SelectBehavior.Select }
    ),
    ['<C-p>'] = cmp.mapping.select_prev_item(
      { behavior = cmp.SelectBehavior.Select }
    ),
    ['<C-n>'] = cmp.mapping.select_next_item(
      { behavior = cmp.SelectBehavior.Select }
    ),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    ['<C-f>'] = cmp.mapping(function(fallback)
      if vim.fn["vsnip#jumpable"](1) then
        vim.cmd("<Plug>(vsnip-jump-next)")
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<C-b>'] = cmp.mapping(function(fallback)
      if vim.fn["vsnip#jumpable"](-1) then
        vim.cmd("<Plug>(vsnip-jump-prev)")
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end, {'i', 's'}),
  },
})

