return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		keys = function()
			local telescope = require("telescope.builtin")

			-- ===============================
			-- == Functions for key mapping ==
			-- ===============================

			-- Find all files.
			-- * Show hidden file.
			-- * Show ignored files.
			local function find_all_files()
				telescope.find_files({ hidden = true, no_ignore = true, no_ignore_parent = true })
			end

			-- Find open buffers.
			local function find_buffers()
				telescope.buffers({ sort_mru = true, sort_lastused = true })
			end

			-- Search for a string.
			local function find_string()
				telescope.live_grep({ show_line = true })
			end

			-- Lists diagnostics.
			local function find_diagnostics()
				telescope.diagnostics({ severity_bound = 0 })
			end

			-- ============
			-- == Keymap ==
			-- ============

			return {
				{ "<Leader><Leader>", find_buffers, desc = "Buffers" },
				{ "<Leader>fa", find_all_files, desc = "[a]ll files" },
				{ "<Leader>fb", telescope.builtin, desc = "[b]uiltins" },
				{ "<Leader>fc", telescope.command_history, desc = "[c]ommand history" },
				{ "<Leader>fd", find_diagnostics, desc = "[d]iagnostic" },
				{ "<Leader>ff", telescope.git_files, desc = "Git files" },
				{ "<Leader>fF", telescope.find_files, desc = "[F]iles (without hidden)" },
				{ "<Leader>fh", telescope.help_tags, desc = "[h]elp" },
				{ "<Leader>fk", telescope.keymaps, desc = "[k]eymaps" },
				{ "<Leader>fm", telescope.man_pages, desc = "[m]an pages" },
				{ "<Leader>fq", telescope.quickfix, desc = "[q]uickfix" },
				{ "<Leader>fr", telescope.oldfiles, desc = "[r]ecent files" },
				{ "<Leader>ft", telescope.current_buffer_fuzzy_find, desc = "in [t]his file" },
				{ "<Leader>fs", find_string, desc = "by [s]tring" },
			}
		end,
		opts = function()
			local actions = require("telescope.actions")

			-- open files in the first window that is an actual file.
			-- use the current window if no other window is available.
			local function get_selection_window()
				local wins = vim.api.nvim_list_wins()
				table.insert(wins, 1, vim.api.nvim_get_current_win())

				for _, win in ipairs(wins) do
					local buf = vim.api.nvim_win_get_buf(win)
					if vim.bo[buf].buftype == "" then
						return win
					end
				end

				return 0
			end

			return {
				defaults = {
					prompt_prefix = " ",
					selection_caret = " ",
					get_selection_window = get_selection_window,
					mappings = {
						n = {
							["q"] = actions.close,
							["<Tab>"] = "toggle_selection",
							["<S-Tab>"] = "toggle_selection",
							["<C-a>"] = "toggle_all",
							["<C-q>"] = "send_selected_to_qflist",
							["<C-\\>"] = "select_vertical",
							["<C-_>"] = "select_horizontal",
						},
						i = {
							["<Tab>"] = "toggle_selection",
							["<S-Tab>"] = "toggle_selection",
							["<C-a>"] = "toggle_all",
							["<C-q>"] = "send_selected_to_qflist",
							["<C-\\>"] = "select_vertical",
							["<C-_>"] = "select_horizontal",
						},
					},
					extensions = {
						["ui-select"] = { require("telescope.themes").get_dropdown() },
					},
				},
			}
		end,
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			pcall(telescope.load_extension, "fzf")
			pcall(telescope.load_extension, "ui-select")
		end,
	},
}
