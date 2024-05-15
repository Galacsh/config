return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		opts = {
			flavour = "mocha",
			term_colors = true,
			background = { dark = "mocha", light = "latte" },
			-- dims the background color of inactive window
			dim_inactive = {
				enabled = true,
				shade = "dark",
				percentage = 0.1,
			},
			-- see: https://github.com/catppuccin/nvim?tab=readme-ov-file#integrations
			integrations = {
				cmp = true,
				gitsigns = true,
				harpoon = false,
				markdown = true,
				mason = false,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
				noice = false,
				notify = false,
				treesitter = true,
				telescope = {
					enabled = true,
				},
				which_key = false,
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
