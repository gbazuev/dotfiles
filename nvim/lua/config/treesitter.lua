--[[Currently Treesitter plugin occures some errors
1. Error while downloading parsers
2. Error with config (lua structure)
]]

require("nvim-treesitter.install").prefer_git = true

local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

treesitter.setup({
    ensure_installed = { "c", "lua", "cpp" },

    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    },
})
