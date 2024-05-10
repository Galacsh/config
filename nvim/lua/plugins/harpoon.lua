return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {{ "nvim-lua/plenary.nvim", lazy = true }},
    keys = function()
      local harpoon = require("harpoon")

      local function add()
        harpoon:list():add()
      end

      local function quick_menu()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end

      local mappings = {
        { "<Leader>ha", add,        silent = true, noremap = true, desc = "Harpoon - add file" },
        { "<Leader>hh", quick_menu, silent = true, noremap = true, desc = "Harpoon - list" },
      }

      local function switch_to(num)
        return {
          "<Leader>" .. tostring(num),
          function() harpoon:list():select(num) end,
          silent = true, 
          noremap = true, 
          desc = "Switch to #" .. tostring(num)
        }
      end

      for n = 1, 9 do
        table.insert(mappings, switch_to(n))
      end

      return mappings
    end,
    config = function(_, opts)
      -- harpoon2 needs ":setup" instead ".setup"
      require("harpoon"):setup(opts)
    end,
  }
}
