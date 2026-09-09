require("mason").setup()

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>m", "<cmd>Mason<CR>", opts)

local capabilities = require("blink.cmp").get_lsp_capabilities({
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
		completion = { completionItem = { snippetSupport = true } },
	},
})
vim.lsp.config("*", {
	capabilities = capabilities,
})
-- local lspconfig = require("lspconfig")

-- local util = require("lspconfig/util")
-- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
vim.keymap.set({ "n", "v" }, "<c-c>", vim.lsp.buf.code_action, opts)
vim.keymap.set("n", "fr", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>i", "<cmd>che vim.lsp<CR>", opts)
vim.keymap.set("n", "<leader>y", "<cmd>lsp restart<CR>", opts)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {
	desc = "Mostrar diagnósticos bajo el cursor",
})
vim.keymap.set("n", "<leader>,", "<cmd>lua vim.diagnostic.jump({count=-1, float=false})<cr>", opts)
vim.keymap.set("n", "<leader>.", "<cmd>lua vim.diagnostic.jump({count=1, float=false})<cr>", opts)
vim.keymap.set("n", "<leader>df", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
vim.keymap.set("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", opts)
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#81a1c1" })
vim.keymap.set("n", "k", vim.lsp.buf.hover, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
-- vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references()<CR>", {})
vim.keymap.set("n", "gr", function()
	local tel = require("telescope.builtin")
	tel.lsp_references()
end)

vim.diagnostic.config({
	-- signs = true,
	virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
		},
	},
})

vim.lsp.enable({
	"lua_ls",
	"html",
	"kulala_ls",
	"ts_ls",
	"cssls",
	"gopls",
	"emmet_ls",
	"dartls",
})
