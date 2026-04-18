return {
	{
		"williamboman/mason.nvim",
		config = function()
			local mason_ = require("mason")
			mason_.setup();
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls", "gopls", "rust_analyzer", "clangd",
					"jdtls", "html", "vtsls", "basedpyright",
				},
				automatic_enable = {
					"lua_ls", "gopls", "rust_analyzer", "clangd",
					"jdtls", "html", "vtsls", "basedpyright",
				}
			})

			vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, {})
		end
	},
	{
		"neovim/nvim-lspconfig",
		setup = function()
			vim.lsp.enable({
				"lua_ls",
				"gopls",
				"clangd",
				"jdtls",
				"html",
				"vtsls",
				"basedpyright",
				"rust_analyzer"
			})
		end
	},
	{

		"neovim/nvim-lspconfig",
		setup = function()
			vim.lsp.config("basedpyright", {
				settings = {
					basedpyright = {
						typeCheckingMode = "standard",
						analysis = {
							reportUnknownMemberType = 'none',
							reportArgumentType = 'none',
							reportUnknownArgumentType = 'none',
							reportUnknownParameterType = 'none',
							reportMissingParameterType = 'none',
							reportUnannotatedClassAttribute = 'none',
						}
					}
				}

			})
		end
	},

	{

		"neovim/nvim-lspconfig",
		setup = function()
			print("lua-ls")
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true)
						}
					}
				}
			})
		end
	}

}
