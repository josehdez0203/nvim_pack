-- nvim-treesitter (rama main) instala el parser y, además, enlaza las queries
-- de resaltado en stdpath("data")/site/queries. Sin ese enlace el parser existe
-- pero no hay colores: get_installed() cuenta parser y queries, así que
-- listar aquí un lenguaje también repara sus queries.
--
-- Los lenguajes incrustados dependen de que exista el parser del lenguaje
-- incrustado, no solo el del archivo anfitrión: sin "javascript" no se
-- resalta <script> dentro de HTML, sin "gotmpl" no se resaltan las directivas
-- {{ ... }} de las plantillas Go y sin "templ" no hay resaltado en *.templ.
require("nvim-treesitter").install({
	-- núcleo de esta configuración
	"bash",
	"cmake",
	"css",
	"dart",
	"desktop",
	"gitignore",
	"go",
	"gomod",
	"html",
	"hyprlang",
	"json",
	"lua",
	"make",
	"markdown",
	"markdown_inline",
	"query",
	"regex",
	"scss",
	"sql",
	"toml",
	"vimdoc",
	"yaml",
	-- plantillas
	"gotmpl",
	"templ",
	-- lenguajes incrustados en web
	"javascript",
	"typescript",
	"tsx",
	"vue",
	"svelte",
})

-- Neovim no asocia estos filetypes con el parser correspondiente y, sin esto,
-- .jsx/.tsx se quedan sin resaltado aunque el parser esté instalado (el
-- autocmd de abajo pide un parser con el nombre del filetype).
vim.treesitter.language.register("javascript", { "javascriptreact" })
vim.treesitter.language.register("tsx", { "typescriptreact" })

-- get_available() devuelve nombres de parser, no filetypes. Se usa para no
-- avisar de buffers como NvimTree o TelescopePrompt, que no tienen parser.
local available = require("nvim-treesitter.config").get_available()
local warned = {}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(args)
		local buf = args.buf
		-- Hover and other temporary LSP buffers do not need a parser.
		if vim.bo[buf].buftype ~= "" then
			return
		end
		local ft = vim.bo[buf].filetype

		local lang = vim.treesitter.language.get_lang(ft)
		if not lang then
			return
		end

		local ok_add = pcall(vim.treesitter.language.add, lang)
		if not ok_add then
			-- get_lang() devuelve el propio filetype cuando no hay nada
			-- registrado, así que solo avisamos de lenguajes que existen en
			-- nvim-treesitter (una vez por lenguaje).
			if not warned[lang] and vim.tbl_contains(available, lang) then
				warned[lang] = true
				vim.notify(
					("Falta el parser de treesitter '%s': ejecuta :TSInstall %s"):format(lang, lang),
					vim.log.levels.WARN
				)
			end
			return
		end

		pcall(vim.treesitter.start, buf, lang)
	end,
})
