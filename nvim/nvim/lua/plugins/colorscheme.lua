return {
	{
		"https://github.com/vague2k/vague.nvim",
		name = "vague",
		lazy = false,
		priority = 1000,
		config = function ()
			-- vim.cmd.colorscheme("vague")
		end
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},

	{ 
		"ellisonleao/gruvbox.nvim",
		priority = 1000 ,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true,
				contrast = "hard",
				invert_tabline = true,
				-- overrides = {
				-- 	String = { fg = "#ebdbb2" },
				-- },
			})
		end
	},

	{
    "RRethy/nvim-base16",
    priority = 1000,
    config = function()
        -- vim.cmd("colorscheme base16-gruvbox-dark-hard")
    end,
	},
	{
		"wincent/base16-nvim",
		lazy = false, -- load at start
		priority = 1000, -- load first
		config = function()
			vim.cmd([[colorscheme gruvbox-dark-hard]])
			vim.o.background = 'dark'
			vim.cmd([[hi Normal ctermbg=NONE]])
			-- Less visible window separator
			vim.api.nvim_set_hl(0, "WinSeparator", { fg = 1250067 })
			-- Make comments more prominent -- they are important.
			local bools = vim.api.nvim_get_hl(0, { name = 'Boolean' })
			vim.api.nvim_set_hl(0, 'Comment', bools)
			-- Make it clearly visible which argument we're at.
			local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
			vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true })
			-- XXX
			-- Would be nice to customize the highlighting of warnings and the like to make
			-- them less glaring. But alas
			-- https://github.com/nvim-lua/lsp_extensions.nvim/issues/21
			-- call Base16hi("CocHintSign", g:base16_gui03, "", g:base16_cterm03, "", "", "")
		end
	},
}

