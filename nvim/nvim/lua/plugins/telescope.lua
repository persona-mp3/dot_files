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

			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")

			local function select_and_flash(prompt_bufnr)
				actions.select_default(prompt_bufnr)
				local was_on = vim.wo.cursorline
				vim.wo.cursorline = true
				vim.defer_fn(function()
					if not was_on then vim.wo.cursorline = false end
				end, 900)
			end

			telescope.setup({
				defaults = {
					mappings = {
						i = { ["<CR>"] = select_and_flash },
						n = { ["<CR>"] = select_and_flash },
					}
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
