local shared = require("lsp.shared")

vim.lsp.config["lua_ls"] = {
  capabilities = shared.capabilities,
  on_attach = shared.on_attach,

  settings = {
    Lua = {
      diagnostics = { globals = { "vim" }},
      workspace = { checkThirdParty = false },
      hint = { enable = true },
    },
  },
}

