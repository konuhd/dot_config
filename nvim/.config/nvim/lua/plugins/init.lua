return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {},
  },
}
