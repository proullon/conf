return {
  "williamboman/mason-lspconfig.nvim",
  lazy = false,
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
  },

  config = function()
    -- servers setup
    require("lsp.shared").setup_mason()

    require("lsp.servers.lua")
    require("lsp.servers.rust")
    require("lsp.servers.go")
  end,
}
