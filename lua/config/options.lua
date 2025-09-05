-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = false
vim.g.completion_enabled = true

if vim.fn.getenv("TERM_PROGRAM") == "ghostty" then
  vim.opt.title = true
  -- Sets tab/window title to the name of the current working directory (the project folder)
  vim.opt.titlestring = "nvim " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end
