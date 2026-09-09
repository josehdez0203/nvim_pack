local opts = {
	default_run_args = nil,
	widget_guides = {
		enabled = true,
	},
	decorations = {
		statusline = {
			app_version = true,
			device = true,
		},
	},
	closing_tags = {
		highlight = "Comment", -- highlight for the closing tag
		prefix = "//", -- character to use for close tag e.g. > Widget
		enabled = true, -- set to false to disable
	},
	dev_log = {
		enabled = true,
		notify_errors = false, -- if there is an error whilst running then notify the user
		open_cmd = "54vs", -- command to use to open the log buffer
		focus_on_open = false,
		filter = function(linea)
			-- "EGL_emulation|InputMethodManager|TextInput|I/flutter"
			local ignore_patterns = {
				"EGL_emulation",
				"InputMethodManager",
				"TextInput",
				"D/InsetsController",
			}
			for _, pattern in ipairs(ignore_patterns) do
				if linea:find(pattern) then
					return false
				end
			end
			return true
		end,
	},
	lsp = {
		color = {
			enabled = true,
			background = true,
			virtual_text = false,
		},
	},
}
require("flutter-tools").setup(opts)

-- flutter-tools.nvim difiere la creación de comandos hasta visitar un buffer
-- Dart. Inicialízalo aquí cuando Neovim se abre desde un proyecto Flutter, para
-- que :FlutterRun y Telescope estén disponibles sin esperar al primer buffer.
if vim.uv.fs_stat(vim.fn.getcwd() .. "/pubspec.yaml") then
	require("flutter-tools").setup_project({})
end

require("telescope").load_extension("flutter")
vim.keymap.set("n", "<C-t>", "<CMD>Telescope flutter commands<CR>", {})
-- vim.keymap.set("n", "<space>f", "<C-W>K", {})
vim.keymap.set("n", "<space>s", ":54vsplit<CR>", {})
