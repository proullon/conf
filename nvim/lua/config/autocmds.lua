-- Open Obsidian "today" if Neovim starts with no file arguments
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- no file passed, no stdin input
    if vim.fn.argc() == 0 and vim.fn.line2byte("$") == -1 then
      vim.cmd("Obsidian today")
    end
  end,
})

