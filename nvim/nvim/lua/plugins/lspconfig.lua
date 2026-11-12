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
			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						checkOnSave = true,
						check = {
							command = "clippy",
						},
					},
				},
			})

			vim.lsp.config("jdtls", {
				-- settings = {
				-- 	java = {
				-- 		format = {
				-- 			enabled = true,
				-- 			settings = {
				-- 				url = vim.fn.expand("~/.config/nvim/java-formatter.xml"),
				-- 				profile = "NvimJava",
				-- 			},
				-- 		},
				-- 	},
				-- },
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls", "gopls", "clangd",
					"jdtls", "html", "vtsls",
					"tombi", "bashls",
				},
				automatic_enable = {
					"lua_ls", "gopls", "clangd",
					"jdtls", "html", "vtsls", "intellij-server", 
					"tombi", "bashls",
				}
			})

			vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, {})

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.rs",
				callback = function()
					local params = vim.lsp.util.make_range_params()
					params.context = { only = { "source.organizeImports" } }
					local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
					for cid, res in pairs(result or {}) do
						for _, r in pairs(res.result or {}) do
							local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
							if r.edit then
								vim.lsp.util.apply_workspace_edit(r.edit, enc)
							elseif r.command then
								vim.lsp.buf.execute_command(r.command)
							end
						end
					end
				end,
			})
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
				-- "basedpyright",
				"rust_analyzer"
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
