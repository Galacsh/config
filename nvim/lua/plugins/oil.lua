return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
      { "<Leader>e", "<Cmd>Oil --float<CR>", silent = true, noremap = true, desc = "Explorer" }
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
        ["<C-\\>"] = "actions.select_vsplit",
        ["<C-=>"] = "actions.select_split",
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
    config = function(_, opts)
      local oil = require("oil")

      --[[
        Overrides oil.nvim's close method.
        Prevents closing it `bprev` fails.

        See: https://github.com/stevearc/oil.nvim/blob/master/lua/oil/init.lua#L411
      --]]
      oil.close = function()
        if vim.w.is_oil_win then
          local original_winid = vim.w.oil_original_win
          vim.api.nvim_win_close(0, true)
          if original_winid and vim.api.nvim_win_is_valid(original_winid) then
            vim.api.nvim_set_current_win(original_winid)
          end
          return
        end
        local ok, bufnr = pcall(vim.api.nvim_win_get_var, 0, "oil_original_buffer")
        if ok and vim.api.nvim_buf_is_valid(bufnr) then
          vim.api.nvim_win_set_buf(0, bufnr)
          if vim.w.oil_original_view then
            vim.fn.winrestview(vim.w.oil_original_view)
          end
          return
        end

        local oilbuf = vim.api.nvim_get_current_buf()
        ok = pcall(vim.cmd.bprev)
        if not ok then
          -- ===============================================
          -- == Send notification and return immediately. ==
          -- ===============================================
          vim.notify("No more buffers to switch to.", vim.log.levels.INFO)
          return
        end
        vim.api.nvim_buf_delete(oilbuf, { force = true })
      end

      oil.setup(opts)
    end
  }
}

