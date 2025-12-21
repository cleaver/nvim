-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "E", "$", { noremap = true })

vim.keymap.set("n", "gF", function()
  local cfile = vim.fn.expand("<cfile>")
  local fname, lnum = cfile:match("([^:]+):(%d+)")
  if fname and lnum then
    vim.cmd("edit " .. fname)
    vim.cmd(lnum)
  else
    vim.cmd("normal! gf")
  end
end, { buffer = 0, desc = "Go to file:line under cursor" })

-- copy Buffer Line. EG: `test/my_app/foo_test.exs:69`
vim.keymap.set("n", "<leader>bl", function()
  local path = vim.fn.expand("%") -- relative to cwd
  local line = vim.fn.line(".")
  local s = ("%s:%d"):format(path, line)
  vim.fn.setreg("+", s) -- system clipboard
  vim.notify("Copied: " .. s)
end, { desc = "Clipboard buffer file:line" })
