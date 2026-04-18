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


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo(true, {
			{ "[X] skilled issued hard, could not clone lazynvim\n", "ErrorMsg" },
			{ out,                                                   "WarningMsg" },
			{ "\n [i] get outta here" },
		}, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup("plugins")

require("config.keymaps")
require("config.floating_terminal")
require("config.custom_terminal_mode")

vim.cmd.colorscheme("retrobox")

-- AUTOCOMMANDS
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


vim.keymap.set('n', '<leader>fm', vim.lsp.buf.format)
