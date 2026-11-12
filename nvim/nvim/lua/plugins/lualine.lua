-- return {
-- 	"nvim-lualine/lualine.nvim",
-- 	config = function()
-- 		require('lualine').setup({
-- 			options = {
-- 				icons_enabled = false, 
-- 				theme = "auto",
-- 				component_separators = { left = '|', right = '|'},
-- 				section_separators = { left = '', right=''},
-- 			},
-- 			sections = {
-- 				lualine_a = {
-- 					{
-- 						"filename",
-- 						file_status = true,
-- 						path = 1,
-- 					}
-- 				},
-- 				lualine_b = { 
-- 					{
-- 						"diagnostics",
-- 						symbols = {
-- 							error = "*"
-- 						}
-- 					}
-- 				},
-- 				lualine_y = {},
-- 				lualine_x = {
-- 					{"lsp_status" }, 
-- 					{
-- 						function()
-- 							return os.date("%H:%M")
-- 						end,
-- 						color = { bg = "NONE", fg="#4d7d80" },
-- 					}
-- 				},
-- 			},
-- 		})
-- 	end
-- }
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

		-- toggle lualine
		local hidden = false
		local saved_laststatus = vim.o.laststatus

		vim.keymap.set("n", "<leader>kk", function()
			hidden = not hidden
			if hidden then
				saved_laststatus = vim.o.laststatus
			end
			require("lualine").hide({
				place = { "statusline" },
				unhide = not hidden,
			})
			vim.o.laststatus = hidden and 0 or saved_laststatus
		end, { desc = "Toggle lualine" })
	end
}
