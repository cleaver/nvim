return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lexical = {
          cmd = { "expert" },
          root_dir = function(fname)
            return require("lspconfig").util.root_pattern("mix.exs", ".git")(fname) or vim.loop.cwd()
          end,
          filetypes = { "elixir", "eelixir", "heex" },
          settings = {},
        },
      },
    },
  },
}
