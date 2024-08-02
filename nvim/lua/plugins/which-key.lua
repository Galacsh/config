local hints = {
	{ "<Leader>e", desc = "Explorer" },
	{ "<Leader>f", group = "+ Find" },
	{ "<Leader>g", group = "+ Git" },
	{ "<Leader>h", group = "+ Harpoon" },
	{ "<Leader>n", group = "+ Notification" },
	{ "<Leader>x", group = "+ Problems" },
	{ "<Leader>r", group = "+ Refactor" },
	{ "<Leader>rn", desc = "Rename" },
	{ "<Leader>rf", desc = "Reformat" },
	{ "<Leader>q", desc = "Close buffer" },
	{ "<Leader>Q", desc = "Exit" },
	{ "<Leader>\\", desc = "Split vertically" },
	{ "<Leader>-", desc = "Split horizontally" },
	{ "m0", desc = "Clear marks" },
	{ "<C-h>", desc = "Jump to the left window" },
	{ "<C-j>", desc = "Jump to the below window" },
	{ "<C-k>", desc = "Jump to the above window" },
	{ "<C-l>", desc = "Jump to the right window" },
	{ "][", desc = "Previous buffer" },
	{ "[]", desc = "Next buffer" },
	{ "<S-l>", desc = "Jump to the end of the line" },
	{ "<S-h>", desc = "Jump to the start of the line" },
	{ "gy", desc = "Copy to clipboard" },
	{ "gp", desc = "Paste from clipboard" },
	{ "<C-a>", desc = "Select all" },
	{ "<M-F12>", desc = "Toggle terminal" },
}

return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = {
				spelling = { enabled = false },
			},
		},
		config = function(_, opts)
			local which_key = require("which-key")
			which_key.setup(opts)
			which_key.add(hints)
		end,
	},
}
