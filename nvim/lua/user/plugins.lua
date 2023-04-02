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
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("folke/todo-comments.nvim") -- todo comments
	use("kyazdani42/nvim-web-devicons") -- icons
	use("kyazdani42/nvim-tree.lua") -- tree
	use("akinsho/bufferline.nvim") -- buffers
	use("moll/vim-bbye") -- close buffers without messing up
	use("nvim-lualine/lualine.nvim") -- bottom line w/ info
	use("akinsho/toggleterm.nvim") -- terms inside neovim
	use("ahmedkhalf/project.nvim") -- project management
	use("lewis6991/impatient.nvim") -- faster startup
	use("lukas-reineke/indent-blankline.nvim") -- indentation line
	use("goolord/alpha-nvim") -- dashboard
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use("folke/which-key.nvim") -- menu for keybindings
	use("nacro90/numb.nvim") -- peek at line numbers
	use("andymass/vim-matchup") -- block % endblock
	use("folke/zen-mode.nvim") -- zen mode :ZenMode

	-- Colorschemes
	-- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
	-- use "lunarvim/darkplus.nvim"
	-- use "lunarvim/onedarker.nvim"
	use("navarasu/onedark.nvim")

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp") -- cmp source for nvim-lsp
	-- AI completion
	--use({
	--	"zbirenbaum/copilot-cmp",
	--	after = { "copilot.lua" },
	--	config = function()
	--		require("copilot_cmp").setup()
	--	end,
	--})
	use({ "tzachar/cmp-tabnine", commit = "1a8fd2795e4317fd564da269cc64a2fa17ee854e", run = "./install.sh" })

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
	use("ray-x/lsp_signature.nvim") -- show function signature
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use({ "RRethy/vim-illuminate", commit = "c82e6d04f27a41d7fdcad9be0bce5bb59fcb78e5" })
	use({ "kevinhwang91/nvim-bqf", ft = "qf" }) -- quickfix
	use("SmiteshP/nvim-navic") -- navigation
	use("j-hui/fidget.nvim") -- fidget spinner for lsp

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-media-files.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("p00f/nvim-ts-rainbow")
	use("windwp/nvim-ts-autotag")
	use("kylechui/nvim-surround")

	-- Git
	use("lewis6991/gitsigns.nvim")

	-- Color hexvalues
	use("norcalli/nvim-colorizer.lua")

	-- i3 syntax
	use("mboughaba/i3config.vim")

	-- jinja formatting
	use("Glench/Vim-Jinja2-Syntax")

	-- java
	use({ "mfussenegger/nvim-jdtls", commit = "3a148dac526396678f141a033270961d0d9ccb88" })
	-- DAP
	use({ "mfussenegger/nvim-dap", commit = "014ebd53612cfd42ac8c131e6cec7c194572f21d" })
	use({ "rcarriga/nvim-dap-ui", commit = "d76d6594374fb54abf2d94d6a320f3fd6e9bb2f7" })
	use({ "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" })

	-- github copilot
	--use 'github/copilot.vim' -- used lua version
	use({
		"zbirenbaum/copilot.lua",
		--cmd = "Copilot",
		--event = "VimEnter",
		--config = function()
		--	require("copilot").setup({})
		--end,
	})
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end

	-- data generator and lab run
	use({
		"0x100101/lab.nvim",
		run = "cd js && npm ci",
	})
end)
