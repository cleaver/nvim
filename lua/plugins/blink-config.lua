return {
  "saghen/blink.cmp",
  opts = function(_, opts)
    if vim.b.completion == nil then
      vim.b.completion = vim.g.completion_enabled
    end

    local completion_toggle = Snacks.toggle({
      name = "Completion",
      get = function()
        return vim.b.completion
      end,
      set = function(state)
        vim.b.completion = state
      end,
    })

    local function toggle_completion()
      require("blink.cmp").hide()
      completion_toggle:toggle()
    end

    vim.keymap.set({ "n" }, "<leader>cx", toggle_completion, { desc = "Toggle Completion" })
    opts.enabled = function()
      return vim.b.completion
    end

    return opts
  end,
}
