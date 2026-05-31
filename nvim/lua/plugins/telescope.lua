return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		priority = 1000,
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },

		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					file_ignore_patterns = { "node_modules", "%.git", "ven", "env", "__pycache_", "target" },

					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "bottom",
							width = 0.9,
							height = 0.9,
							preview_width = 0.6,
							-- mirror = true,
						}
					},
					sorting_strategy = "ascending"
				}
			})

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Run through buffers in telelscope" })
			vim.keymap.set("n", "<leader>s", builtin.live_grep, { desc = "Acts as live grep in cwd" })
		end

	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = { require("telescope.themes").get_dropdown {} }
				}
			})
			require("telescope").load_extension("ui-select")
		end
	},
}
