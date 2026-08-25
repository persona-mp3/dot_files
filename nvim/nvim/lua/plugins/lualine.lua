return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require('lualine').setup({
			options = {
				icons_enabled = false, 
				theme = "auto",
				component_separators = { left = '|', right = '|'},
				section_separators = { left = '', right=''},
			},
			sections = {
				lualine_a = {
					{
						"filename",
						file_status = true,
						path = 1,
					}
				},
				lualine_b = { 
					{
						"diagnostics",
						symbols = {
							error = "*"
						}
					}
				},
				lualine_y = {},
				lualine_x = {
					{"lsp_status" }, 
					{
						function()
							return os.date("%H:%M")
						end,
						color = { bg = "NONE", fg="#4d7d80" },
					}
				},
			},
		})
	end
}
