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

	vim.api.nvim_set_option_value("winblend", 5, { win = win })
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

		vim.api.nvim_set_option_value("winblend", 5, { win = state.win })
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
