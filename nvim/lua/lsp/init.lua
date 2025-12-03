return {
  -- Mason
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason <-> LSP
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("plugins.lsp.shared").setup_mason()
      require("plugins.lsp.servers.lua")
      require("plugins.lsp.servers.rust")
      require("plugins.lsp.servers.go")
    end,
  },
}
