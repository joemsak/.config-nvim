return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	--[[{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ruby_lsp" },
			})
		end,
	},]]
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.ruby_lsp.setup({
				init_options = {
					formatter = "standard",
					linters = { "standard" },
				},
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})

			vim.keymap.set("n", "<leader>fa", function()
				vim.lsp.buf.execute_command({ command = "ruby-lsp.fixAll" })
			end, { noremap = true, silent = true })

			-- Function to apply all code actions across the file
			local function apply_all_code_actions()
				local params = vim.lsp.util.make_range_params()
				params.context = { diagnostics = vim.diagnostic.get(0) }

				local bufnr = vim.api.nvim_get_current_buf()
				for i = 1, vim.api.nvim_buf_line_count(bufnr) do
					params.range = { start = { i - 1, 0 }, ["end"] = { i - 1, -1 } }
					vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(_, result, _)
						if result and #result > 0 then
							for _, action in pairs(result) do
								if action.edit or type(action.command) == "table" then
									vim.lsp.buf.execute_command(action.command)
								end
							end
						end
					end)
				end
			end

			-- Keymap for applying all code actions in the file
			vim.keymap.set("n", "<leader>aa", apply_all_code_actions, { noremap = true, silent = true })

      --Apply code format after save
			--[[
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = "*",
				callback = function()
					vim.lsp.buf.format({ async = true })
				end,
			})
      --]]
		end,
	},
}
