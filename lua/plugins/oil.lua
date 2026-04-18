return {
	{
		"https://github.com/stevearc/oil.nvim" ,
		config = function() 
			local oil = require("oil")
			oil.setup({
				default_file_explorer = true,
				columns = {"icon"},
				float = {
					max_width = 0.7,
					max_height = 0.7,
					preview_split = "right",
					
				},
				sort = {
					sorter = "case_sensitive",
					directories_first = true,
				},

				keymaps = {
					["q"] = { "actions.close", mode = 'n' },
				},

				win_options = {
					number = false,
					relativenumber = false,
					spell = false,
					signcolumn = "yes:2",
					conceallevel = 3
				},

				view_options = {
					show_hidden = true,
				}

			})

			vim.keymap.set("n", "<leader>e", ":Oil --float<CR>")
		end
	},
}
