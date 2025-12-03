return {
  {
    "lervag/vimtex",
    ft = { "tex", "latex" },
    config = function()
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_view_general_method = "zathura"
      vim.g.vimtex_quickfix_mode = 0
      vim.opt.conceallevel = 1
      vim.g.tex_conceal = "abdmg"

      -- Spelling for latex
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function()
          vim.opt_local.spell = true
        end,
      })
    end,
  },
}

