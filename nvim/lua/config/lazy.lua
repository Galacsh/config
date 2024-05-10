-- [[ Configure Lazy.nvim ]] --

-- where to install
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- install if not installed
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({
    "git", 
    "clone", 
    "--filter=blob:none", 
    "--branch=stable", 
    lazyrepo, 
    lazypath
  })
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------

-- options
local opts = {
	lazy = true,
	checker = { enabled = false },
	defaults = { version = false },
	install = {
    missing = true,
		colorscheme = { "catppuccin", "habamax" },
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarplugin",
				"tohtml",
				"tutor",
				"zipplugin",
        "netrwPlugin"
			},
		},
	},
}

require("lazy").setup("plugins", opts)

