-- global
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0

-- number lines
vim.opt.number = true
vim.opt.relativenumber = true

-- identation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.breakindent = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- ui
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 1
vim.opt.wrap = false

-- system
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true

-- other
-- Remove the colon from the triggers that cause re-indentation
vim.opt.cinkeys:remove(":")
vim.opt.indentkeys:remove(":")

require("config.lazy")
