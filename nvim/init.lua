-- Use 'Helper' globally
require("helper")

require("config.vim")
require("config.autocmd")
require("config.lazy")

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

--[[
  Useful help docs:
  - :help vim.opt
  - :help vim.keymap.set()
  - :help lua-guide
  - :help lua-guide-autocommands
  - :help 'list'
  - :help 'listchars'
  - :help option-list
  - :help mapleader
--]]

