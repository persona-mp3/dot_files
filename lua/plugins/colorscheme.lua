return {
	{
		"https://github.com/vague2k/vague.nvim",
		name = "vague",
		lazy = false,
		priority = 1000,
		config = function ()
			vim.cmd.colorscheme("vague")
		end
	},
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({
				style = 'darker',
			})
		end
	},
}

