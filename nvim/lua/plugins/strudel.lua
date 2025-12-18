return {
{
  "gruvw/strudel.nvim",
  build = "npm ci",
  config = function()
    require("strudel").setup({
      -- tes options ici (voir plus bas)
    })
  end,
},
}
