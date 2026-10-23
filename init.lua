-- require("vim._core.ui2").enable({})

-- Registra las extensiones antes de cargar plugins y de abrir los buffers
-- pasados como argumentos a Neovim. El filetype genérico "template" no activa
-- ni el resaltado ni los servidores de lenguaje.
--
--   *.templ  -> templ   (Go + HTML; parser "templ" y servidor templ-ls)
--   *.tmpl   -> html    (plantilla Go sobre HTML; ver after/queries/html)
--   *.gotmpl -> gotmpl  (plantilla Go sin HTML)
vim.filetype.add({
	extension = {
		conf = "tmux",
		templ = "templ",
		tmpl = "html",
		gohtml = "html",
		gotmpl = "gotmpl",
	},
})

require("options")
require("keymaps")
require("snippets")
require("pack")
require("commands")

vim.cmd([[set clipboard+=unnamedplus ]])
vim.cmd([[colorscheme catppuccin-macchiato]])
