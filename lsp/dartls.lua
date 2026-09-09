---@brief
---
--- https://github.com/dart-lang/sdk/tree/master/pkg/analysis_server/tool/lsp_spec
---
--- Language server for dart.

---@type vim.lsp.Config
return {
	cmd = { "dart", "language-server", "--protocol=lsp" },
	filetypes = { "dart" },
	root_markers = { "pubspec.yaml" },
	init_options = {
		onlyAnalyzeProjectsWithOpenFiles = true,
		suggestFromUnimportedLibraries = true,
		closingLabels = true,
		outline = true,
		flutterOutline = true,
	},
	handlers = {
		["dart/textDocument/publishClosingLabels"] = require("flutter-tools.labels").closing_tags,
	},
	---@type lspconfig.settings.dartls
	settings = {
		dart = {
			completeFunctionCalls = true,
			showTodos = true,
		},
		-- widget_guides = {
		-- 	enabled = true,
		-- },
		-- decorations = {
		-- 	statusline = {
		-- 		app_version = true,
		-- 		device = true,
		-- 	},
		-- },
		-- closing_tags = {
		-- 	highlight = "Comment", -- highlight for the closing tag
		-- 	prefix = "//", -- character to use for close tag e.g. > Widget
		-- 	enabled = true, -- set to false to disable
		-- },
		-- dev_log = {
		-- 	enabled = true,
		-- 	notify_errors = false, -- if there is an error whilst running then notify the user
		-- 	open_cmd = "54vs", -- command to use to open the log buffer
		-- 	focus_on_open = false,
		-- 	filter = function(linea)
		-- 		-- "EGL_emulation|InputMethodManager|TextInput|I/flutter"
		-- 		local ignore_patterns = {
		-- 			"EGL_emulation",
		-- 			"InputMethodManager",
		-- 			"TextInput",
		-- 			"D/InsetsController",
		-- 		}
		-- 		for _, pattern in ipairs(ignore_patterns) do
		-- 			if linea:find(pattern) then
		-- 				return false
		-- 			end
		-- 		end
		-- 		return true
		-- 	end,
		-- },
	},
}
