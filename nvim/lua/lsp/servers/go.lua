local shared = require("lsp.shared")

vim.lsp.config["gopls"] = {
  capabilities = shared.capabilities,
  on_attach = shared.on_attach,

  settings = {
    gopls = {
      gofumpt = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
        unreachable = true,
      },
    },
  },
}

vim.lsp.config["golangci_lint_ls"] = {
  capabilities = shared.capabilities,
  on_attach = shared.on_attach,
}

