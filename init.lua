-- require("vim._core.ui2").enable({})

require("options")
require("keymaps")
require("snippets")
require("pack")
require("commands")

vim.cmd([[set clipboard+=unnamedplus ]])
vim.cmd([[colorscheme catppuccin-macchiato]])
