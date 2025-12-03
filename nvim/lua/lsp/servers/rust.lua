local shared = require("lsp.shared")

vim.lsp.config["rust_analyzer"] = {
  capabilities = shared.capabilities,

  on_attach = function(client, bufnr)
    shared.on_attach(client, bufnr)

    -- Format Rust on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({
          async = false,
          filter = function(c)
            return c.name == "rust_analyzer"
          end,
        })
      end,
    })
  end,

  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true,
        enableExperimental = true,
        styleLints = { enable = true },
      },

      rustfmt = {
        extraArgs = {
          "+nightly",
          "--config", "format_code_in_doc_comments=true",
          "--config", "edition=2024",
        },
      },

      check = {
        command = "clippy",
        extraArgs = {
          "--",
          "-Wclippy::pedantic",
          "-Aclippy::redundant_else",
          "-Aclippy::too_many_lines",
        },
      },

      cargo = {
        allTargets = false,
        extraEnv = { CARGO_BUILD_JOBS = "4" },
        buildScripts = { enable = true, numJobs = 4 },
      },

      files = {
        excludeDirs = {
          "target", "node_modules", "dist", "build", ".venv", ".git",
        },
      },
    },
  },
}

