-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "E", "$", { noremap = true })

-- go to file:line under cursor
--
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
--
vim.keymap.set("n", "<leader>bl", function()
  local path = vim.fn.expand("%") -- relative to cwd
  local line = vim.fn.line(".")
  local s = ("%s:%d"):format(path, line)
  vim.fn.setreg("+", s) -- system clipboard
  vim.notify("Copied: " .. s)
end, { desc = "Clipboard buffer file:line" })

-- go to file_path:line_number in clipboard
--
local function goto_clipboard_fileline()
  local clip = vim.fn.getreg("+")
  if clip == nil or clip == "" then
    vim.notify("Clipboard is empty", vim.log.levels.WARN)
    return
  end

  clip = vim.trim(clip)

  -- parse "path:line"
  local path, lnum = clip:match("^(.*):(%d+)$")
  if not path or not lnum then
    vim.notify("Clipboard does not look like file:line", vim.log.levels.WARN)
    return
  end

  -- if not absolute, resolve against project root (LazyVim) or CWD
  local is_absolute = vim.fs ~= nil and vim.fs.dirname(path) ~= nil and path:sub(1, 1) == "/"
  if not is_absolute then
    local root = nil
    pcall(function()
      root = require("lazyvim.util").root.get()
    end)
    if not root or root == "" then
      root = vim.loop.cwd()
    end
    path = root .. "/" .. path
  end

  path = vim.fn.expand(path)

  vim.cmd.edit(path)
  vim.cmd(tostring(lnum))
end

vim.keymap.set("n", "gp", goto_clipboard_fileline, { desc = "Go to file:line from clipboard" })

-- override position of default terminal
--
vim.keymap.set("n", "<leader>ft", function()
  Snacks.terminal(nil, { cwd = LazyVim.root(), win = { position = "right" } })
end, { desc = "Terminal (Root Dir)" })

-- open terminal in directory of current buffer - window to the right
--
vim.keymap.set("n", "<leader>bt", function()
  local file = vim.api.nvim_buf_get_name(0)
  local dir = file ~= "" and vim.fn.fnamemodify(file, ":p:h") or vim.loop.cwd()
  Snacks.terminal(nil, { cwd = dir, win = { position = "right" } })
end, { desc = "Terminal (buffer dir) - right" })

-- open terminal in directory of current buffer - window below
--
vim.keymap.set("n", "<leader>bT", function()
  local file = vim.api.nvim_buf_get_name(0)
  local dir = file ~= "" and vim.fn.fnamemodify(file, ":p:h") or vim.loop.cwd()
  Snacks.terminal(nil, { cwd = dir })
end, { desc = "Terminal (buffer dir) - below" })

-- Quick macro maps
--
vim.keymap.set("n", "<F1>", "@a", { desc = "Play macro @a" })
vim.keymap.set("n", "<F2>", "@b", { desc = "Play macro @b" })
vim.keymap.set("n", "<F3>", "@c", { desc = "Play macro @c" })
vim.keymap.set("n", "<F4>", "@d", { desc = "Play macro @d" })
vim.keymap.set("n", "<F5>", "@q", { desc = "Play macro @q" })
