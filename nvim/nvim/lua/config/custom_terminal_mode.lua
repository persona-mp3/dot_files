-- =========================
-- Terminal Workspace System
-- =========================

-- 1. Open terminal in new tab
vim.keymap.set("n", "<leader>t", function()
	print("Entering terminal workspace")
  vim.cmd("tabnew")
  vim.cmd("terminal")
  vim.cmd("startinsert")
end, { desc = "Open terminal in new tab" })


-- 2. Mark terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.b.is_term_tab = true
  end,
})


-- 2b. Block buffer navigation inside terminal tabs
local function block_if_term()
  return vim.b.is_term_tab
end

local function safe_cmd(cmd)
  return function()
    if not block_if_term() then
      vim.cmd(cmd)
    else
      print("Blocked in terminal tab")
    end
  end
end

vim.keymap.set("n", "]b", safe_cmd("bnext"))
vim.keymap.set("n", "[b", safe_cmd("bprev"))
vim.keymap.set("n", "<leader>bn", safe_cmd("bnext"))
vim.keymap.set("n", "<leader>bp", safe_cmd("bprev"))


-- 3. Ctrl + number → jump to tab
for i = 1, 9 do
  vim.keymap.set("n", "<M-" .. i .. ">", function()
    vim.cmd("tabn " .. i)
  end, { desc = "Go to tab " .. i })
end


-- 4. Auto-close tab when terminal exits
vim.api.nvim_create_autocmd("TermClose", {
  callback = function()
    vim.schedule(function()
      if vim.bo.buftype == "terminal" then
        pcall(vim.cmd, "tabclose")
      end
    end)
  end,
})


-- Helper: extract a "name" for the terminal
local function get_term_name()
  local cmd = vim.b.terminal_job_name or vim.b.term_title or ""

  -- fallback: try parsing command
  if cmd == "" then
    return "terminal"
  end

  -- clean up common formats
  cmd = cmd:gsub(".*:", "")   -- remove prefixes like :bash
  cmd = cmd:gsub(".*/", "")   -- remove paths

  if cmd == "" then
    return "terminal"
  end

  return cmd
end


-- Set tab title when terminal opens
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.b.is_term_tab = true

    -- delay so job info exists
    vim.schedule(function()
      local name = get_term_name()
      vim.cmd("file " .. name)
    end)
  end,
})
