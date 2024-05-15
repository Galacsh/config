return {
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile", "VeryLazy" },
		opts = {
			indent = {
				char = "▏",
				tab_char = "▏",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"dashboard",
					"lazy",
					"mason",
					"notify",
				},
			},
			whitespace = {
				remove_blankline_trail = false,
			},
		},
		main = "ibl",
	},
}
