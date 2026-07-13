--require("gitgo").setup()
local navbuddy = require("nvim-navbuddy")
navbuddy.setup({
	lsp = { auto_attach = true },
})
vim.keymap.set("n", "gl", "<cmd>Navbuddy<CR>", {})
require("dropbar").setup()
local dropbar_api = require("dropbar.api")
vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
local snipe = require("snipe")
snipe.setup({
	position = "center",
})
vim.keymap.set("n", "<leader>g", snipe.open_buffer_menu, { desc = "Abre snipe" })
