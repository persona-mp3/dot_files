-- popup menu
vim.opt.pumheight = 10
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.pumblend = 0
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>ww', ':wa<CR>')
vim.keymap.set('n', '<leader>qq', ':qa!<CR>')


-- BUFFER OPERATIONS
vim.keymap.set('n', '<leader>x', ':bdelete<CR>')
vim.keymap.set('n', '<Tab>', ':bn<CR>')


-- escape from terminal to normal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
vim.keymap.set('n', '<Esc>', ":nohl<CR>")

-- -- terminal mode
-- vim.keymap.set({ "n" }, "<leader>t", ":term<CR><C-wl>")



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
---


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

vim.keymap.set('n', '<leader>qf', ":Telescope diagnostics<CR>")


vim.keymap.set('n', '<leader>cs', function()
	local colorschemes = vim.fn.getcompletion('', 'color')

	vim.ui.select(colorschemes, {
		prompt = 'Colorschemes',
	}, function(chosen)
		if not chosen then return end
		vim.cmd('colorscheme ' .. chosen)
	end)
end, { desc = 'Change colorscheme' })
