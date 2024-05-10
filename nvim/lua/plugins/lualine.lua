return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      local fg = Helper.get_foreground

      vim.o.laststatus = vim.g.lualine_laststatus

      return {
        options = {
          theme = "catppuccin",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        },
        sections = {
          lualine_a = {{ "mode", padding = { left = 1, right = 1 }}},
          lualine_b = {{ "branch", padding = { left = 1, right = 1 }}},
          lualine_c = {
            { "diagnostics", symbols = Helper.icons.diagnostics },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename" },
          },
          lualine_x = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = fg("Statement"),
              separator = " ",
              padding = { right = 1 },
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = fg("Special"),
              separator = " ",
              padding = { right = 1 },
            },
            {
              "diff",
              symbols = Helper.icons.git,
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
              padding = { right = 1 },
            },
          },
          lualine_y = {{ "progress", padding = { left = 1, right = 1 }}},
          lualine_z = {{ "location", padding = { left = 1, right = 1 }}},
        },
        extensions = { "fzf", "lazy" },
      }
    end,
    config = function(_, opts)
      require("lualine_require").require = require
      require("lualine").setup(opts)
    end
  }
}

