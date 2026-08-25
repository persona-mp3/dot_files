-- Floating Git Terminal for Neovim
-- Add this to your Neovim config (e.g., ~/.config/nvim/lua/git-float.lua)

local M = {}

local buf = nil
local win = nil

-- Create centered floating window
local function create_float()
  -- Get editor dimensions
  local width = vim.o.columns
  local height = vim.o.lines

  -- Calculate window size (60% of editor)
  local win_width = math.floor(width * 0.6)
  local win_height = math.floor(height * 0.6)

  -- Calculate position to center the window
  local row = math.floor((height - win_height) / 2)
  local col = math.floor((width - win_width) / 2)

  -- Create buffer if it doesn't exist
  if not buf or not vim.api.nvim_buf_is_valid(buf) then
    buf = vim.api.nvim_create_buf(false, true) -- no file, scratch buffer
  end

  -- Window options
  local opts = {
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  }

  -- Create the window
  win = vim.api.nvim_open_win(buf, true, opts)

  -- Start terminal in the buffer
  vim.fn.termopen(vim.o.shell, {
    on_exit = function()
      -- Close window when terminal exits (Ctrl-D)
      if win and vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end,
  })

  -- Enter insert mode automatically
  vim.cmd("startinsert")
end

-- Toggle the floating terminal
function M.toggle()
  if win and vim.api.nvim_win_is_valid(win) then
    -- If window is open, close it
    vim.api.nvim_win_close(win, true)
    win = nil
  else
    -- If window is closed, open it
    create_float()
  end
end

return M
