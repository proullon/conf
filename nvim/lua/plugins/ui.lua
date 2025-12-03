return {
  -- Nightfox theme (duskfox)
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme duskfox")
    end,
  },

  -- Modern icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- Statusline (feline replacement)
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          icons_enabled = true,
          section_separators = "",
          component_separators = "",
        },
      })
    end,
  },

  -- improved UI
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },
}
