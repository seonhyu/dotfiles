-- Neovim Configuration Entry Point
-- LazyVim-style modular structure

-- Set leader keys before plugins load
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Nerd Font support
vim.g.have_nerd_font = true

-- Enable 24-bit RGB color
vim.opt.termguicolors = true

-- Bootstrap lazy.nvim and load configuration
require("config.lazy")

-- vim: ts=2 sts=2 sw=2 et
