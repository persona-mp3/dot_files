return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      go = { "golangcilint" },
    }

		vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
			callback = function()
				local config = vim.fn.glob(vim.fn.getcwd() .. "/.golangci.yml")
				if config ~= "" then
					require("lint").try_lint()
				end
			end,
		})

  end,
}

