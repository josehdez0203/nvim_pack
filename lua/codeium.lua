-- require("opencode").setup({
--
-- 	input = {}, -- Enhances `ask()`
-- 	picker = { -- Enhances `select()`
-- 		actions = {
-- 			opencode_send = function(...)
-- 				return require("opencode").snacks_picker_send(...)
-- 			end,
-- 		},
-- 		win = {
-- 			input = {
-- 				keys = {
-- 					["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
-- 				},
-- 			},
-- 		},
-- 	},
-- })
-- vim.g.opencode_opts = {
-- 	-- Your configuration, if any; goto definition on the type or field for details
-- }
--
-- vim.o.autoread = true -- Required for `vim.g.opencode_opts.events.reload`
--
-- -- Recommended/example keymaps
-- vim.keymap.set({ "n", "x" }, "<leader>oa", function()
-- 	require("opencode").ask("@this: ")
-- end, { desc = "Ask opencode…" })
-- vim.keymap.set({ "n", "x" }, "<leader>os", function()
-- 	require("opencode").select()
-- end, { desc = "Select opencode…" })
--
-- vim.keymap.set({ "n", "x" }, "go", function()
-- 	return require("opencode").operator("@this ")
-- end, { desc = "Add range to opencode", expr = true })
-- vim.keymap.set("n", "goo", function()
-- 	return require("opencode").operator("@this ") .. "_"
-- end, { desc = "Add line to opencode", expr = true })
--
-- vim.keymap.set("n", "<S-C-u>", function()
-- 	require("opencode").command("session.half.page.up")
-- end, { desc = "Scroll opencode up" })fv
-- vim.keymap.set("n", "<S-C-d>", function()
-- 	require("opencode").command("session.half.page.down")
-- end, { desc = "Scroll opencode down" })
-- require("codex").setup({
-- 	keymaps = {
-- 		toggle = nil, -- Keybind to toggle Codex window (Disabled by default, watch out for conflicts)
-- 		quit = "<C-q>", -- Keybind to close the Codex window (default: Ctrl + q)
-- 	}, -- Disable internal default keymap (<leader>cc -> :CodexToggle)
-- 	border = "rounded", -- Options: 'single', 'double', or 'rounded'
-- 	width = 0.8, -- Width of the floating window (0.0 to 1.0)
-- 	height = 0.8, -- Height of the floating window (0.0 to 1.0)
-- 	model = nil, -- Optional: pass a string to use a specific model (e.g., 'o3-mini')
-- 	autoinstall = true, -- Automatically install the Codex CLI if not found
-- 	panel = false, -- Open Codex in a side-panel (vertical split) instead of floating window
-- 	use_buffer = false, -- Capture Codex stdout into a normal buffer instead of a terminal buffer
-- })
--
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>ca", -- Change this to your preferred keybinding
-- 	function()
-- 		require("codex").toggle()
-- 	end,
-- 	{ desc = "Toggle Codex popup or side-panel" }
-- )
-- require("codex").status() -- drop in to your lualine sections
-- --### Usage:
-- -- Call `:Codex` (or `:CodexToggle`) to open or close the Codex popup or side-panel.
-- -- Map your own keybindings via the `keymaps.toggle` setting.
-- -- To choose floating popup vs side-panel, set `panel = false` (popup) or `panel = true` (panel) in your setup options.
-- -- To capture Codex output in an editable buffer instead of a terminal, set `use_buffer = true` (or `false` to keep terminal) in your setup options.
-- -- Add the following code to show backgrounded Codex window in lualine:
-- -- add this to the file where you setup your other plugins:
local neocodeium = require("neocodeium")
local blink = require("blink.cmp")

vim.api.nvim_create_autocmd("User", {
	pattern = "BlinkCmpMenuOpen",
	callback = function()
		neocodeium.clear()
	end,
})

neocodeium.setup({
	filter = function()
		return not blink.is_visible()
	end,
})
vim.keymap.set("i", "<C-t>", neocodeium.accept)

-- vim.keymap.set("i", "<C-n>", neocodeium.next)
-- vim.keymap.set("i", "<C-p>", neocodeium.previous)
-- vim.keymap.set("i", "<C-c>", neocodeium.cancel)
neocodeium.get_status()
