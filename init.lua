-- Keybinds	con
vim.g.mapleader = " "
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.swapfile = false
vim.opt.winborder = "rounded"
vim.opt.smartindent = true
-- popup menu
vim.opt.pumheight = 10
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.pumblend = 0

-- terminal config

-- escapae from terminal to normal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
vim.keymap.set('n', '<Esc>', ":nohl<CR>")

-- terminal mode
vim.keymap.set({ "n" }, "<leader>t", ":term<CR><C-wl>")

-- open explorer with space + e
vim.keymap.set('n', '<leader>e', ':Oil --float<CR>')
--
-- vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>ww', ':wa<CR>')

vim.keymap.set('n', '<Tab>', ':bn<CR>')
vim.keymap.set('n', '<leader>qq', ':qa!<CR>')
vim.keymap.set('n', '<leader>x', ':bdelete<CR>')


-- vim.keymap.set('n', '<leader>s', ':Lazy sync<CR>')
vim.keymap.set('n', '<leader>fm', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>so', ':source ~/.config/nvim/init.lua<CR>')

-- ==================== for automcomplete navigation ==============
vim.keymap.set('i', '<Tab>', function()
	return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
end, { expr = true })

vim.keymap.set('i', '<S-Tab>', function()
	return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
end, { expr = true })

vim.keymap.set('i', '<CR>', function()
	return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
end, { expr = true })
--- ===============================================================


-- Using lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "[X] skilled issued hard, could not clone lazynvim\n", "ErrorMsg" },
			{ out,                                                   "WarningMsg" },
			{ "\n [i] get outta here" },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)


vim.o.cmdheight = 0


-- ======= plugins =========
require("lazy").setup({
	{
		"https://github.com/vague2k/vague.nvim",
		name = "vague",
		lazy = false,
		priority = 1000,
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("lualine").setup {
				options = {
					theme = "auto",
					section_separators = ' ',
					component_separators = '  ',
				},
				sections = {
					-- lualine_a = { "mode" },
					lualine_a = {
						{ "mode", color = { bg = 'none', fg = 'white', gui = 'bold' } }
					},
					lualine_b = { { "branch", icon = "*", color = { bg = 'none', fg = '#b85c5c' } } },
					lualine_c = { { "filename", file_status = true, path = 1, color = { bg = 'none', fg = "#4d7c86" } } },
					lualine_x = { { "diagnostics", sections = { "error", "warn" }, bg = 'none' } },
					-- lualine_x = { { "encoding", "filetype" }, {
					-- 	"diagnostics",
					-- 	sections = { "error", "warn" }
					-- } },
					lualine_y = { { "lsp_status", icon = '', bg = 'none' } },
					-- lualine_z = { "time %{strftime('%H:%M')}" }, -- clock on the right
					lualine_z = {
						{ function()
							return ' ' .. os.date('%H:%M')
						end,
							color = { fg = '#4d7c86', bg = 'none', gui = 'bold' }
						},

						-- color = { bg = "none" },
					}, -- clock on the right

				},

				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "encoding", "filetype" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = {},
			}
		end
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
		}
	},
	{
		"NTBBloodbath/doom-one.nvim",
		name = "doomchad",
	},
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({
				style = 'darker',
			})
		end
	},
	{
		"https://github.com/neovim/nvim-lspconfig",
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		priority = 1000,
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		-- config = function()
		-- 	vim.keymap.set("n", "<leader>ss", require("telescope.builtin").current_buffer_fuzzy_find
		-- 	)
		-- end


		config = function()
			require("telescope").setup({
				defaults = {
					-- file_ignore_patterns = { "node_modules", "%.git", "dist", "ven", "env", "__pycache_" },
					file_ignore_patterns = { "node_modules", "%.git", "ven", "env", "__pycache_", "target" },
					layout_strategy = "vertical",
					layout_config = { width = 0.7 }
					-- layout_config = {
					-- 	preview_width = 0.6,
					-- },
				},
				-- extensions = {
				-- 	["ui-select"] = {
				-- 		require("telescope.themes").get_dropdown {}
				-- 	}
				-- }

			})
		end

	},

	{ "https://github.com/stevearc/oil.nvim" },

	{
		"https://github.com/mason-org/mason.nvim",
		opts = {}
	},

	-- for jumping between projects
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup {
				exclude_dirs = {
					"~",
					"MakersAdmin",
					"~/.config/nvim",
					"~/.local/share/nvim",
				},
				detection_methods = { "pattern" },
				patterns = {
					".git",
					"Cargo.toml",  -- rust
					"package.json", -- ts/js
					"pyproject.toml", -- python,
					"requirements.txt", -- python (older projects)
					"go.mod",      -- go
				},
			}
		end
	},

	{ 'nvim-telescope/telescope-ui-select.nvim' },

})

-- require("telescope").load_extension("ui-select")

-- ====== telescope-config ======
-- require("telescope").setup({
-- 	defaults = {
-- 		-- file_ignore_patterns = { "node_modules", "%.git", "dist", "ven", "env", "__pycache_" },
-- 		file_ignore_patterns = { "node_modules", "%.git", "ven", "env", "__pycache_", "target" },
-- 		layout_strategy = "vertical",
-- 		layout_config = { width = 0.7 }
-- 		-- layout_config = {
-- 		-- 	preview_width = 0.6,
-- 		-- },
-- 	},
--
-- 	extensions = {
-- 		projects = {
-- 			action = function(proj)
-- 				vim.cmd("%bd")
-- 				vim.cmd("cd" .. proj)
-- 				require("oil").open(proj)
-- 			end
-- 		}
-- 	},
--
-- })

-- require("telescope").load_extension("projects")
vim.keymap.set("n", "<leader>fn", function()
	local projects = require("project_nvim").get_recent_projects()
	vim.ui.select(projects, { prompt = "Select project" }, function(proj)
		if proj then
			if proj == vim.fn.getcwd() then
				require("oil").open(proj)
				return
			end
			vim.cmd("%bd!")
			vim.cmd("cd " .. proj)
			require("oil").open(proj)
		end
	end)
end)

-- clear history
vim.keymap.set("n", "<leader>fh", ":!rm ~/.local/share/nvim/project_nvim/project_history<CR>")


local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Run through buffers in telelscope" })
vim.keymap.set("n", "<leader>ss", builtin.live_grep, { desc = "Acts as live grep in cwd" })

-- set up quick fix for all errors in your shitty code
vim.keymap.set("n", "<leader>qf", builtin.diagnostics, { desc = "shows all dianogstics errors" })


-- ==== oil-config ====
require("oil").setup({
	default_file_explorer = true,
	buf_options = {
		buflisted = false,
		bufhidden = "hide",
	},
	float = {
		max_width = 0.6,
		max_height = 0.6,
	},
	columns = { " icon" },
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
		signcolumn = "yes:2"
	},

	view_options = {
		show_hidden = true,
	}


})


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

-- Tells lua that vim is a global variable
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true)
			}
		}
	}
})

vim.lsp.config("svelteserver", {})

vim.lsp.config("vtsls", {
	settings = {
		typescript = {
			preferences = {
				includeInlayParameterNameHints = "all",
			},
		},
		vtsls = {
			experimental = {
				completion = {
					enableServerSideFuzzyMatch = true,
				},
			},
		},
	},
	-- add this:
	handlers = {
		["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
			if result.diagnostics then
				for _, diag in ipairs(result.diagnostics) do
					-- TypeScript error code 2304 = "Cannot find name"
					-- TypeScript error code 2552 = "Cannot find name (did you mean...)"
					-- TypeScript error code 2339 = "Property does not exist"
					if diag.code == 2304 or diag.code == 2552 or diag.code == 2339 then
						diag.severity = vim.diagnostic.severity.ERROR
					end
				end
			end
			vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
		end,
	},
})


-- Autocompletion
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end

		vim.keymap.set('n', 'K', function()
			vim.lsp.buf.hover({ border = 'rounded' })
		end, { buffer = ev.buf }
		)


		vim.keymap.set('n', '<C-k>', function()
			vim.lsp.buf.signature_help({ border = 'rounded' })
		end, { buffer = ev.buf })


		-- For goto definitions
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf })
	end,
})



vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})



-- ==== lsp dianogstics ======
vim.diagnostic.config({
	virtual_text = {
		spacing = 6,
		prefix = '*',
	},
	signs = true,
	float = {
		border = "rounded",
	},
	update_in_insert = false,
	severity_sort = true,
})

-- vim.cmd.colorscheme("retrobox")
vim.cmd.colorscheme("vague")



-- Setup LuaSnip
local luasnip = require('luasnip')

-- Setup nvim-cmp
local cmp = require('cmp')
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
})

-- vim.o.statusline = "%f %=%{strftime('%H:%M')} 🫀"

--
-- Floating Terminal Toggle
-- Place this in your init.lua or a separate file sourced by it
-- Toggle with <leader>t

local state = {
	buf = nil,
	win = nil,
}

local function create_float()
	local width  = math.floor(vim.o.columns)
	local height = math.floor(vim.o.lines)
	local col    = math.floor((vim.o.columns - width) / 2)
	local row    = math.floor((vim.o.lines - height) / 2)

	local buf    = vim.api.nvim_create_buf(false, true)

	local win    = vim.api.nvim_open_win(buf, true, {
		relative  = "editor",
		width     = width,
		height    = height,
		col       = col,
		row       = row,
		style     = "minimal",
		border    = "rounded",
		title     = " Terminal ",
		title_pos = "center",
	})

	vim.api.nvim_set_option_value("winblend", 10, { win = win })
	vim.api.nvim_set_option_value("winhighlight", "Normal:NormalFloat", { win = win })

	vim.fn.termopen(vim.o.shell)


	return buf, win
end

local function toggle_terminal()
	-- Window is open → close it
	if state.win and vim.api.nvim_win_is_valid(state.win) then
		vim.api.nvim_win_close(state.win, false)
		state.win = nil
		return
	end

	-- Buffer still alive → re-open window around it
	if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
		local width  = math.floor(vim.o.columns)
		local height = math.floor(vim.o.lines)
		local col    = math.floor((vim.o.columns - width) / 2)
		local row    = math.floor((vim.o.lines - height) / 2)

		state.win    = vim.api.nvim_open_win(state.buf, true, {
			relative  = "editor",
			width     = width,
			height    = height,
			col       = col,
			row       = row,
			style     = "minimal",
			border    = "rounded",
			title     = " Terminal ",
			title_pos = "center",
		})

		vim.api.nvim_set_option_value("winblend", 8, { win = state.win })
		vim.api.nvim_set_option_value("winhighlight", "Normal:NormalFloat", { win = state.win })
		vim.cmd("startinsert")
		return
	end

	-- Nothing exists yet → create fresh
	state.buf, state.win = create_float()
	vim.cmd("startinsert")
end

-- Close with <Esc> or <leader>t while in terminal mode
vim.keymap.set("n", "<C-j>", toggle_terminal, { desc = "Toggle floating terminal" })
vim.keymap.set("t", "<C-j>", function()
	vim.api.nvim_win_close(state.win, false)
	state.win = nil
end, { desc = "Close floating terminal" })
