local hints = {
  ["<Leader>e"] = { nil, "Explorer" },
  ["<Leader>f"] = { nil, "+ Find" },
  ["<Leader>g"] = { nil, "+ Git" },
  ["<Leader>h"] = { nil, "+ Harpoon" },
  ["<Leader>n"] = { nil, "+ Notification" },
  ["<Leader>x"] = { nil, "+ Problems" },
  ["<Leader>r"] = {
    name = "+ Refactor",
    ["n"] = { nil, "Rename" },
    ["f"] = { nil, "Reformat" },
  },
  ["<Leader>q"] = { nil, "Close buffer" },
  ["<Leader>Q"] = { nil, "Exit" },
  ["<Leader>\\"] = { nil, "Split vertically" },
  ["<Leader>-"] = { nil, "Split horizontally" },
  ["m0"] = { nil, "Clear marks" },
  ["<C-h>"] = { nil, "Jump to the left window" },
  ["<C-j>"] = { nil, "Jump to the below window" },
  ["<C-k>"] = { nil, "Jump to the above window" },
  ["<C-l>"] = { nil, "Jump to the right window" },
  ["]["] = { nil, "Previous buffer" },
  ["[]"] = { nil, "Next buffer" },
  ["<S-l>"] = { nil, "Jump to the end of the line" },
  ["<S-h>"] = { nil, "Jump to the start of the line" },
  ["gy"] = { nil, "Copy to clipboard" },
  ["gp"] = { nil, "Paste from clipboard" },
  ["<C-a>"] = { nil, "Select all" },
  ["<M-F12>"] = { nil, "Toggle terminal" },
}

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        spelling = { enabled = false },
      }
    },
    config = function(_, opts)
      local which_key = require("which-key")
      which_key.setup(opts)
      which_key.register(hints)
    end,
  }
}
