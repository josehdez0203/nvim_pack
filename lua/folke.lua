local Snacks = require("snacks")
Snacks.setup({
	image = { enable = true },
	picker = {
		exclude = {
			"node_modules",
			".git",
		},
	},
})

vim.keymap.set("n", "ff", function()
	Snacks.picker.files({ hidden = true })
end, { desc = "File picker" })
vim.keymap.set("n", "df", function()
	Snacks.picker.diagnostics({ hidden = true })
end, { desc = "diagnostics picker" })
vim.keymap.set("n", "ds", function()
	Snacks.picker.diagnostics_buffer()
end, { desc = "Diagnostics buffer" })
vim.keymap.set("n", "fg", function()
	Snacks.picker.grep()
end, { desc = "Grep picker" })
vim.keymap.set("n", "ft", function()
	Snacks.picker.help()
end, { desc = "Help picker" })
vim.keymap.set("n", "fk", function()
	Snacks.picker.keymaps()
end, { desc = "Keymaps picker" })
vim.keymap.set("n", "fs", function()
	Snacks.picker.colorschemes()
end, { desc = "colorschemes picker" })
vim.keymap.set("n", "fv", function()
	Snacks.picker.files({ cwd = vim.fn.stdpath("config"), hidden = true })
end, { desc = "vim config" })
vim.keymap.set("n", "fo", function()
	Snacks.picker.recent()
end, { desc = "Oldfiles picker" })
-- vim.keymap.set("n", "<leader>e", function()
-- 	Snacks.picker.explorer()
-- end, { desc = "Explorer" })

-- Highlight todo, notes, etc in comments
require("todo-comments").setup({ signs = false })
vim.keymap.set("n", "gt", "<cmd>TodoTelescope<cr>", { desc = "Ver Todos" })
require("paint").setup({
	---@type PaintHighlight[]
	highlights = {
		{
			-- filter can be a table of buffer options that should match,
			-- or a function called with buf as param that should return true.
			-- The example below will paint @something in comments with Constant
			filter = { filetype = "lua" },
			pattern = "%s*%-%-%-%s*(@%w+)",
			hl = "Constant",
		},
	},
})
require("noice").setup()
