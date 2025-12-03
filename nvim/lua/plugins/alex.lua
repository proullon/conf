return {
  {
    -- Local path
    dir = "/home/proullon/work/src/github.com/proullon/alex",
    name = "alex",
    lazy = false,
    config = function()
      require("alex").setup({
        endpoint = "http://127.0.0.1:8080/chat",
      })

      -- Reload function
      vim.api.nvim_create_user_command("AlexReload", function()
        package.loaded["alex"] = nil
        package.loaded["alex.chat"] = nil
        require("alex").setup({
          endpoint = "http://127.0.0.1:8080/chat",
        })
      end, {})
    end,
  },
}

