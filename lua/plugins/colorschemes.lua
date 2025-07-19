return {
  {
    "ellisonleao/gruvbox.nvim",
    -- lazy = false, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        overrides = {
          Function = { link = "GruvboxGreen" },
        },
      })
      -- Load the colorscheme here
      -- vim.cmd.colorscheme 'gruvbox'
    end,
  },
  {
    "olimorris/onedarkpro.nvim",
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_palette = "material"
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
}
