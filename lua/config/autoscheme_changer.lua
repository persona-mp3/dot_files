local function set_colorscheme_by_time()
	local hour = tonumber(os.date("%H"))
	local min = tonumber(os.date("%M"))
	local after_830 = hour > 8 or (hour == 8 and min >= 30)

	if after_830 then
		print("autoscheme::vague")
		vim.cmd("colorscheme vague")
	else
		vim.cmd("colorscheme retrobox") -- change this
		print("autoscheme::retrobox")
	end
end

set_colorscheme_by_time()

vim.api.nvim_create_autocmd({ "FocusGained", "VimEnter" }, {
	callback = set_colorscheme_by_time,
})
