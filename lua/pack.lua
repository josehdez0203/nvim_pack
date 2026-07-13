local paquetes = require("paquetes")
vim.pack.add(paquetes)

require("treesitter")
require("lsp")
require("blink")
require("none-ls")
require("nvim-autopairs").setup()
require("lua_line")
require("comment")
require("nvim-notify")
require("tabs")
require("curl")
require("mini.surround")
require("mini.animate")
require("float_term")
require("git_signs")
require("indent")
require("tinydiags")
require("nav")
require("wiki")
require("render-markdown").setup({
	render_modes = { "n", "c", "t" },
})
require("nvimtree")
require("origamis")
require("rainbow")
require("scroll")
require("flutter_tools")
require("folke")
require("curl").setup()
require("nvimtree")
require("fidget").setup()
local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	highlighters = {
		-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

		-- Highlight hex color strings (`#rrggbb`) using that color
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})
require("codeium")

vim.filetype.add({
	extension = {
		conf = "tmux",
		templ = "html",
	},
})
