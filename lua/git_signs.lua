require("gitsigns").setup({
	signs = {
		add = { text = "" },
		change = { text = "" },
		delete = { text = "󰧧" },
		topdelete = { text = "󰚃 " },
		changedelete = { text = "󰠙" },
		untracked = { text = " " },
	},
	signcolumn = true,
})

vim.keymap.set("n", "tl", ":Gitsigns toggle_signs<CR>", { desc = "Alternar line signs", silent = true })
vim.keymap.set("n", "tg", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Alternar line blame", silent = true })
