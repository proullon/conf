local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("t", "<Esc>", [[<C-\><C-n>]], opts)

map("i", "<C-a>", "<Home>", opts)
map("i", "<C-e>", "<End>", opts)

-- Telescope 
map("n", "<C-p>", "<cmd>Telescope find_files<CR>", opts)
map("n", "<C-g>", "<cmd>Telescope git_grep<CR>", opts)

-- Obsidian quick switch
map("n", "<C-o>", "<cmd>Obsidian quick_switch<CR>", opts)

-- LSP diagnostics
map("n", "<space>e", vim.diagnostic.open_float, opts)
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
map("n", "<space>q", vim.diagnostic.setloclist, opts)

-- GPT command (external cli "gpt")
vim.api.nvim_create_user_command("GPT", function(cmd_opts)
  local prompt = cmd_opts.args
  local handle = io.popen("gpt " .. vim.fn.shellescape(prompt))
  if not handle then
    print("Error running gpt")
    return
  end
  local result = handle:read("*a")
  handle:close()
  print(result)
end, { nargs = 1, complete = "file" })

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Spelling correction of word bellow cursor
map("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", opts)

