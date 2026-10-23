local null_ls = require("null-ls")
local null_ls_utils = require("null-ls.utils")
-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- prettierd no puede inferir un parser para las plantillas HTML (*.tmpl,
-- *.gohtml): su extensión no corresponde a ningún lenguaje de prettier y
-- falla con "No parser could be inferred". En esos buffers el servidor "html"
-- sí sabe formatearlas (lspconfig activa provideFormatter), así que se le deja
-- participar en el guardado además de null-ls.
local function is_html_template(bufnr)
	local name = vim.api.nvim_buf_get_name(bufnr)
	return name:match("%.tmpl$") ~= nil or name:match("%.gohtml$") ~= nil
end

null_ls.setup({
	-- add package.json as identifier for root (for typescript monorepos)
	root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
	-- setup formatters & linters
	sources = {
		--  to disable file types use
		--  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
		-- formatting.prettierd.with({
		--   extra_filetypes = { "svelte" },
		-- }), -- js/ts formatter
		formatting.prettierd.with({
			filetypes = {
				"html",
				"yaml",
				"markdown",
				"toml",
				"css",
				"scss",
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				-- "template",
				"gohtml",
				"json",
				"jsonc",
			},
			-- condition = function(utils)
			--   return utils.root_has_file({ ".prettierrc.js", ".prettierrc" })
			-- end,
		}),
		formatting.shfmt.with({
			filetypes = {
				"sh",
			},
		}),
		-- formatting.prettier.with({
		-- 	filetypes = { "json" },
		-- }),
		formatting.stylua, -- lua formatter
		formatting.isort,
		formatting.black,
		formatting.dart_format,
		formatting.gofumpt.with({
			filetypes = { "go" },
		}),
		-- formatting.phpcbf,
		-- formatting.pretty_php,
		-- formatting.prettier.with({
		--   filetypes = { "php" },
		--   extra_filetypes = { "php" },
		-- }),
		--
		-- diagnostics.pylint,

		-- .env: no hay language server dedicado; dotenv-linter es el linter
		-- estándar. Neovim 0.12 ya detecta *.env y .env.* como filetype
		-- "env" (con syntax/env.vim), pero el builtin de none-ls solo declara
		-- "sh", por eso se amplían los filetypes. Instalación:
		--   :MasonUpdate
		--   :MasonInstall dotenv-linter
		diagnostics.dotenv_linter.with({
			filetypes = { "env", "sh" },
			-- dotenv-linter 4 exige subcomando (`dotenv-linter check <archivo>`);
			-- el builtin de none-ls usa la forma vieja y falla con
			-- "unrecognized subcommand".
			args = { "check", "$FILENAME" },
			-- el builtin ya filtra por nombre *.env*; además se comprueba que
			-- el binario exista para no avisar en cada diagnóstico si falta
			runtime_condition = function(params)
				return vim.fn.executable("dotenv-linter") == 1 and params.bufname:find("%.env.*") ~= nil
			end,
		}),

		-- diagnostics.eslint_d.with({ -- js/ts linter
		--   filetypes = { "js", "ts", "tsx", "jsx" },
		--   -- condition = function(utils)
		--   --   return utils.root_has_file({ ".eslintrc.js", ".eslintrc", ".eslintrc.cjs" }) -- only enable if root has .eslintrc.js or .eslintrc.cjs
		--   -- end,
		-- }),
	},
	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client:supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							-- null-ls (prettierd, stylua, …) formatea siempre
							if client.name == "null-ls" then
								return true
							end
							-- en plantillas HTML prettierd no puede; el servidor
							-- html las formatea igual que el formato manual
							return client.name == "html" and is_html_template(bufnr)
						end,
						bufnr = bufnr,
						-- prettierd arranca en frío en el primer guardado
						timeout_ms = 3000,
					})
				end,
			})
		end
	end,
})

vim.keymap.set("n", "<leader>xx", vim.lsp.buf.format, { desc = "Formatear buffer" })
