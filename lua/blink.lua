local cmp = require("blink.cmp")
cmp.build():wait(6000)

cmp.setup({
	enabled = function()
		return not vim.tbl_contains({ "cpp", "NvimTree", "DressingInput" }, vim.bo.filetype)
	end,

	snippets = { preset = "luasnip" },
	signature = { enabled = true },
	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = "normal",
	},
	sources = {
		default = {
			"snippets",
			"lsp",
			"path",
			"buffer",
			-- "emoji",
		},
		providers = {
			path = {
				module = "blink.cmp.sources.path",
				score_offset = 3,
				fallbacks = { "buffer" },
				opts = {
					trailing_slash = true,
					label_trailing_slash = true,
					get_cwd = function(context)
						return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
					end,
					show_hidden_files_by_default = false,
					-- Treat `/path` as starting from the current working directory (cwd) instead of the root of your filesystem
					ignore_root_slash = false,
				},
			},
			-- emoji = {
			-- 	module = "blink-emoji",
			-- 	name = "Emoji",
			-- 	score_offset = 15, -- Tune by preference
			-- 	opts = {
			-- 		insert = true, -- Insert emoji (default) or complete its name
			-- 		-- -@type string|table|fun():table
			-- 		trigger = function()
			-- 			return { ":" }
			-- 		end,
			-- 	},
			-- },
		},
	},
	keymap = { preset = "default", ["<CR>"] = { "accept", "fallback" }, ["<c-k>"] = false },
	cmdline = {
		enabled = false,
	},
	completion = {
		accept = { auto_brackets = { enabled = true } },
		menu = {
			border = "rounded",
			scrolloff = 1,
			scrollbar = false,
			draw = {
				columns = {
					{ "kind_icon" },
					{ "label", "label_description", gap = 1 },
					{ "kind" },
					{ "source_name" },
				},
			},
		},
		documentation = {
			window = {
				border = "rounded",
				scrollbar = false,
				winhighlight = "Normal:Search,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
			},
			auto_show = true,
			auto_show_delay_ms = 500,
		},
	},
})

require("luasnip.loaders.from_vscode").lazy_load()
