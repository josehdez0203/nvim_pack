require("neowiki").setup({
	wiki_dirs = {
		-- neowiki.nvim supports both absolute and relative paths
		{ name = "Work", path = "~/wiki/work" },
		{ name = "Personal", path = "~/wiki/personal" },
	},
})

vim.keymap.set(
	"n",
	"<leader>ww",
	"<cmd>lua require('neowiki').open_wiki_floating()<cr>",
	{ desc = "Open Floating Wiki" }
)
