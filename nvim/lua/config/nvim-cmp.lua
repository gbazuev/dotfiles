local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
    return
end

local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
    return
end

local luaship_status, luasnip = pcall(require, "luasnip")
if not luaship_status then
    return
end

require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
        mode = "symbol",
        maxwidth = 50,
        ellipsis_char = "...",
        show_labelDetails = true,
        before = function(entry, vim_item)
            return vim_item
        end
    })
  },
  snippet = {
    expand = function(args)
        luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),
  -- sources for autocompletion
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- LSP
    { nape = "luasnip" }, -- snippets
    { name = "buffer" }, -- text within the current buffer
    { name = "path" }, -- file system paths
  }),
})
