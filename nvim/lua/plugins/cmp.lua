return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		enabled = function()
			local buf = vim.api.nvim_win_get_buf(0)
			return vim.bo[buf].modifiable
		end,
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			-- ===============================
			-- == Functions for key mapping ==
			-- ===============================

			-- Select next item (ghost text).
			local function next_item()
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			end

			-- Select previouse item (ghost text).
			local function prev_item()
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			end

			-- If no completion is selected, insert the first one in the list.
			-- If a completion is selected, insert this one.
			local function intelli_select(fallback)
				if cmp.visible() then
					local entry = cmp.get_selected_entry()
					if not entry then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
					end
					cmp.confirm()
				else
					fallback()
				end
			end

			-- If nothing is selected (including preselections) add a newline as usual.
			-- If something has explicitly been selected by the user, select it.
			local function safe_select(fallback)
				if cmp.visible() and cmp.get_active_entry() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				else
					fallback()
				end
			end

			-- Jump to next item inside snippet.
			local function jump_next()
				if luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				end
			end

			-- Jump to previous item inside snippet.
			local function jump_prev()
				if luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				end
			end

			-- =========================
			-- == Key Mapping Presets ==
			-- =========================

			-- Preset for 'insert' and 'select' mode.
			local insert_select_preset = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping(next_item),
				["<C-p>"] = cmp.mapping(prev_item),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<Tab>"] = cmp.mapping(intelli_select, { "i", "s" }),
				["<CR>"] = cmp.mapping({
					i = safe_select,
					s = cmp.mapping.confirm({ select = true }),
				}),
				["<C-Space>"] = cmp.mapping.complete({}),
				["<C-l>"] = cmp.mapping(jump_next, { "i", "s" }),
				["<C-h>"] = cmp.mapping(jump_prev, { "i", "s" }),
			})

			-- Preset for 'command' and 'search' mode.
			local command_search_preset = cmp.mapping.preset.cmdline({
				["<C-n>"] = cmp.mapping(next_item, { "c" }),
				["<C-p>"] = cmp.mapping(prev_item, { "c" }),
				["<Tab>"] = cmp.mapping(intelli_select, { "c" }),
				["<CR>"] = cmp.mapping(safe_select, { "c" }),
			})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				mapping = insert_select_preset,
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})

			-- `/` cmdline setup.
			cmp.setup.cmdline("/", {
				mapping = command_search_preset,
				sources = {
					{ name = "buffer" },
				},
			})

			-- `:` cmdline setup.
			cmp.setup.cmdline(":", {
				mapping = command_search_preset,
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				---@diagnostic disable-next-line: missing-fields
				matching = { disallow_symbol_nonprefix_matching = false },
			})
		end,
	},
}
