return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require('lualine').setup({
			options = {
				theme = "auto",
				section_separators = ' ',
				component_separators = '  ',
			},
			sections = {
				lualine_a = {
					{
						"filename",
						file_status = true,
						path = 4,
					}
				},
				lualine_b = { "branch" },
				lualine_c = {},
				lualine_x = {
					"diagnostics",
					{ "fileformat", symbols = { unix = "  Fedora  ", mac = "", dos = "" } },
				},
				lualine_y = { "lsp_status" }, -- was 'progress' by default
				lualine_z = {},
			},
		})
	end
}
