--All servers that are needed
local servers = {
  "lua_ls",
  "clangd",
  "cmake",
  "autotools_ls"
}

--mason setup
local mason_status, mason = pcall(require, "mason")
if not mason_status then
    return
end

--Mason setup
mason.setup({
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})

--mason-lspconfig setup
local masonlsp_status, masonlsp = pcall(require, "mason-lspconfig")
if not masonlsp_status then
    return
end

masonlsp.setup({
    ensure_installed = servers,
    automatic_installation = true
})

--lspconfig setup
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("config.lsp.handlers").on_attach,
    capabilities = require("config.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = pcall(require, "config.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  lspconfig[server].setup(opts)
end

local null_ls_status, _ = pcall(require, "null-ls")
if not null_ls_status then
    return
end
