return {
	{
		"neovim/nvim-lspconfig",
		-- event = { "BufReadPost", "BufWritePre", "BufNewFile", "VeryLazy" },
		lazy = false,
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "folke/neodev.nvim", opts = {} },
		},
		opts = {
			-- Enable the following language servers
			--  * cmd (table): Override the default command used to start the server
			--  * filetypes (table): Override the default list of associated filetypes for the server
			--  * capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  * settings (table): Override the default settings passed when initializing the server.
			servers = {
				bashls = {},
				cmake = {},
				cssls = {},
				docker_compose_language_service = {},
				dockerls = {},
				eslint = {},
				gopls = {},
				html = {},
				jsonls = {},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = { disable = { "missing-fields" } },
						},
					},
				},
				marksman = {},
				pyright = {},
				rust_analyzer = {},
				tailwindcss = {},
				taplo = {},
				tsserver = {},
				vimls = {},
				yamlls = {},
			},
			others = {
				"shfmt",
				"stylua",
				"prettier",
				"prettierd",
			},
			global_capabilities = {},
		},
		config = function(_, opts)
			--  Every time a new file is opened that is associated with an lsp,
			--  (for example, opening `main.rs` is associated with `rust_analyzer`)
			--  this function will be executed to configure the current buffer.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					-- hello
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					map("gd", require("telescope.builtin").lsp_definitions, "Goto definition")

					-- Find references for the word under your cursor.
					map("gr", require("telescope.builtin").lsp_references, "Goto references")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gi", require("telescope.builtin").lsp_implementations, "Goto implementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("gt", require("telescope.builtin").lsp_type_definitions, "Type definition")

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("<Leader>rn", vim.lsp.buf.rename, "Rename")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<Leader>ca", vim.lsp.buf.code_action, "Code action")

					-- Opens a popup that displays documentation about the word under your cursor
					--  See `:help K` for why this keymap.
					map("<S-k>", vim.lsp.buf.hover, "Hover documentation")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("g<S-d>", vim.lsp.buf.declaration, "Goto Declaration")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
							callback = function(detach_event)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = detach_event.buf })
							end,
						})
					end
				end,
			})

			-- =============================================

			-- Create new capabilities object
			local base_capabilities = vim.lsp.protocol.make_client_capabilities()

			-- Add 'cmp' capabilities
			local has_cmp, cmp = pcall(require, "cmp_nvim_lsp")
			if has_cmp then
				base_capabilities = vim.tbl_deep_extend("force", base_capabilities, cmp.default_capabilities())
			end

			-- =============================================

			local mason = require("mason")
			local registry = require("mason-registry")
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")

			-- Setup 'Mason' first
			mason.setup()

			-- Ensure all packages are installed
			local ensure_installed = Helper.concat(vim.tbl_keys(opts.servers), opts.others)
			local ls_name = mason_lspconfig.get_mappings().lspconfig_to_mason
			for _, pkg_name in ipairs(ensure_installed) do
				local pkg = registry.get_package(ls_name[pkg_name] or pkg_name)
				if not pkg:is_installed() then
					pkg:install()
					vim.notify("Installed '" .. pkg_name .. "'.")
				end
			end

			-- Setup each language server
			mason_lspconfig.setup({
				handlers = {
					function(server_name)
						local server = opts.servers[server_name] or {}

						-- Merge capabilities
						server.capabilities = vim.tbl_deep_extend(
							"force",
							{},
							base_capabilities,
							opts.global_capabilities or {},
							server.capabilities or {}
						)
						lspconfig[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
