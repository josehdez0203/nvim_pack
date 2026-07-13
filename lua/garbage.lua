local MiniFiles = require("mini.files")
MiniFiles.setup({
	mappings = {
		go_in = "<CR>",
		go_in_plus = "L",
		go_out = "_",
		go_out_plus = "H",
	},
})
vim.keymap.set("n", "-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" })

vim.keymap.set("n", "<leader>-", function()
	MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
	MiniFiles.reveal_cmd()
end, { desc = "Toggle into currently opened file" })
local MiniNotify = require("mini.notify")
MiniNotify.setup({
	content = {
		format = function(notif)
			return notif.msg
		end,
	},
})

require("mini.cmdline").setup({
	autocorrect = { enable = false },
})
require("mini.surround").setup()
-- sa Agregar surround
-- sd delete surround
-- sr replace surround

local MiniPick = require("mini.pick")
local MiniExtra = require("mini.extra")
vim.keymap.set("n", "ff", function()
	MiniPick.builtin.files()
end, { desc = "Mini File Picker" })
vim.keymap.set("n", "fg", function()
	MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") })
end, { desc = "Mini File Picker" })
vim.keymap.set("n", "ft", function()
	MiniPick.builtin.help()
end, { desc = "Mini help" })

vim.keymap.set("n", "fd", function()
	MiniExtra.pickers.diagnostic()
end, { desc = "Mini diagnostics" })
vim.keymap.set("n", "ft", function()
	MiniExtra.pickers.keymaps()
end, { desc = "Mini keymaps" })
local MiniCompletion = require("mini.completion")
MiniCompletion.setup({
	lsp_completion = {
		auto_setup = true,
		process_items = function(items, base)
			return MiniCompletion.default_process_items(items, base, {
				filtersort = "fuzzy",
			})
		end,
	},
})

local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
	snippets = {
		MiniSnippets.gen_loader.from_lang(),
	},
})

MiniSnippets.start_lsp_server({ match = false })

-- Desactivar highlight para snippets

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "MiniSnippetsCurrent", {})
		vim.api.nvim_set_hl(0, "MiniSnippetsCurrentReplace", {})
		vim.api.nvim_set_hl(0, "MiniSnippetsFinal", {})
		vim.api.nvim_set_hl(0, "MiniSnippetsUnvisited", {})
		vim.api.nvim_set_hl(0, "MiniSnippetsVisited", {})
	end,
})
