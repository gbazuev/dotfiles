local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use "wbthomason/packer.nvim"                -- Have packer manage itself (for packer update)

	use ({
        "nvim-tree/nvim-tree.lua",
        requires = { "nvim-web-devicons" },
    })                                          -- file browser

    use ({
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-web-devicons" },
    })                                          -- beautiful and user-friendly bottom bar

    use "nvim-tree/nvim-web-devicons"           -- beautiful file (and more) icons. Nerd (patched) font required
    use "onsails/lspkind.nvim"                  -- Icons (function, var etc.) for autocompletion

    use "williamboman/mason.nvim"               -- Package manager for LSP, DAP, linters and formatters
    use "williamboman/mason-lspconfig.nvim"     -- Connector between mason and lspconfig
    use "neovim/nvim-lspconfig"                 -- Quickstart configs for LSP    
    use "hrsh7th/cmp-nvim-lsp"                  -- Source for neovim builtin LSP client
    use "jose-elias-alvarez/null-ls.nvim"       -- Injector for LSP diagnostics, code actions and boilerplate
    use "hrsh7th/nvim-cmp"                      -- A completion engine (root of all Neovim Autocompletion) 
    use "hrsh7th/cmp-buffer"                    -- source for text in buffer
    use "hrsh7th/cmp-path"                      -- source for file system path   
    use "L3MON4D3/LuaSnip"                      -- snippet engine
    use "saadparwaiz1/cmp_luasnip"              -- for autocompletion

    use "rcarriga/nvim-notify"                  -- user-friendly notification system (errors, warnings etc.)
    use "romgrk/barbar.nvim"                    -- convenient top panel with files
    use "nvim-lua/plenary.nvim"                 -- convenient functions that contains boilerplate lua code (for Telescope)
    use "folke/which-key.nvim"                  -- hints fo using keyboard keys
    use "windwp/nvim-autopairs"                 -- brackets and other pairs completion

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        requires = {{ "nvim-lua/plenary.nvim" }}
    })                                          -- search engine

    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    })

    use "zaldih/themery.nvim"                   -- Theme picker

	--THEMES
	use "doums/darcula"
    use "navarasu/onedark.nvim"
    use "ellisonleao/gruvbox.nvim"

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
