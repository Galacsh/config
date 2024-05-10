return {
  {
    "folke/noice.nvim",
    lazy = false,
    dependencies = {
      { "MunifTanjim/nui.nvim" },
      { "rcarriga/nvim-notify" },
      { "nvim-tree/nvim-web-devicons" },
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
    -- stylua: ignore
    keys = {
      { "<Leader>nn", "<Cmd>Noice history<CR>", silent = true, noremap = true, desc = "Notification history" },
      { "<Leader>nd", "<Cmd>Noice dismiss<CR>", silent = true, noremap = true, desc = "Dismiss notifications" },
      { "<C-d>", function() if not require("noice.lsp").scroll(4) then return "<C-d>" end end,  silent = true, noremap = true, expr = true, desc = "Scroll forward",  mode = { "i", "n", "s" } },
      { "<C-u>", function() if not require("noice.lsp").scroll(-4) then return "<C-u>" end end, silent = true, noremap = true, expr = true, desc = "Scroll backward", mode = { "i", "n", "s" } },
    },
  }
}

