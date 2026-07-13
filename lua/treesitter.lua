local configs = require("nvim-treesitter.configs")
configs.setup({
	auto_install = true,
	--ensure_installed= {
	--  "go", "typescript", "javascript", "tsx", "html", "css", "json", "bash",
	--  "http", "dockerfile"
	--},
	highlight = {
		enable = true,
	},
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-Enter>",
			node_incremental = "<C-Enter>",
			scope_incremental = false,
			node_decremental = "<Backspace>",
		},
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(args)
		local buf = args.buf
		local ft = vim.bo[buf].filetype

		local lang = vim.treesitter.language.get_lang(ft)
		if not lang then
			return
		end

		local ok_add = pcall(vim.treesitter.language.add, lang)
		if not ok_add then
			return
		end

		pcall(vim.treesitter.start, buf, lang)
	end,
})
