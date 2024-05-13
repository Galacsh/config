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
        gitsigns = true,
        harpoon = false,
        mini = {
          enabled = true,
          indentscope_color = "",
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
  }
}

