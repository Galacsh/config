return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
      { "<leader>e", "<Cmd>Oil --float<CR>", silent = true, noremap = true, desc = "Explorer" }
    },
    opts = function()
      local function is_hidden_file(name, _)
        return vim.startswith(name, ".")
      end

      local function is_always_hidden(name, _)
        return name == ".DS_Store" or name == "." or name == ".."
      end

      local keymaps_in_oil_buffer = {
        ["q"] = "actions.close",
      }

      return {
        skip_confirm_for_simple_edits = true,
        prompt_save_on_select_new_entry = false,
        keymaps = keymaps_in_oil_buffer,
        use_default_keymaps = true,
        view_options = {
          show_hidden = true,
          is_hidden_file = is_hidden_file,
          is_always_hidden = is_always_hidden,
          sort = {
            { "type", "asc" },
            { "name", "asc" },
          },
        },
      }
    end,
  }
}
