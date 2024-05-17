return {
  {
    "nvimdev/dashboard-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    opts = function()
      local icons = Helper.icons.dashboard

      -- stylua: ignore
      local menu = {
        { icon = icons.explorer,       desc = " Explorer",       key = "e", action = "Oil --float", },
        { icon = icons.find_file,      desc = " Find file",      key = "f", action = "Telescope find_files hidden=true", },
        { icon = icons.new_file,       desc = " New file",       key = "n", action = "ene | startinsert", },
        { icon = icons.harpoon,        desc = " Harpoon",        key = "h", action = "lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())", },
        { icon = icons.recent_files,   desc = " Recent files",   key = "r", action = "Telescope oldfiles", },
        { icon = icons.find_by_string, desc = " Find by string", key = "s", action = "Telescope live_grep", },
        { icon = icons.lazy,           desc = " Lazy",           key = "l", action = "Lazy", },
        { icon = icons.quit,           desc = " Quit",           key = "q", action = "qa", },
      }

      -- calculate padding size to center the "center"
      local function calculate_padding(menu_count)
          local lines = vim.o.lines  -- Get the total lines in the terminal
          local center_size = 2 * menu_count - 1
          return math.floor((lines - center_size) / 2) -- Calculate padding
      end

      local opts = {
        theme = "doom",
        hide = { statusline = false },
        config = {
          header = vim.split(string.rep("@", calculate_padding(#menu)), "@"),
          footer = {},
          center = menu,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  }
}

