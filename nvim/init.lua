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
vim.opt.mouse = ""

-- infinite undo
vim.opt.undofile = true

-- Neat X clipboard integration
-- <leader>p will paste clipboard into buffer
-- <leader>c will copy entire buffer into clipboard
vim.keymap.set('n', '<leader>p', '<cmd>read !wl-paste<cr>')
vim.keymap.set('n', '<leader>c', '<cmd>w !wl-copy<cr><cr>')


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
-- require("config.custom_terminal_mode")
-- require("config.autoscheme_changer")
-- vim.lsp.config.rust_analyzer.setup({
-- 	cmd = {"rust-analyzer"}
-- })
vim.lsp.enable("rust_analyzer", {
})

vim.keymap.set("n", "<leader>gl", function()
    vim.cmd("write")
    vim.cmd("cexpr system('golangci-lint run --disable-all --enable exhaustruct --out-format line-number ./...')")
    vim.cmd("copen")
end, { desc = "Run exhaustruct only" })

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
vim.cmd.colorscheme("base16-gruvbox-dark-hard")
vim.opt.colorcolumn = "85"
