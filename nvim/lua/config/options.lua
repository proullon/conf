local opt = vim.opt
local g = vim.g

opt.encoding = "utf-8"
opt.compatible = false

-- Comportement général
opt.showmatch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.autoread = true

-- Indentation
opt.shiftwidth = 4
opt.autoindent = true
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2

-- Interface
opt.number = true
opt.mouse = "r"
opt.clipboard = "unnamedplus"
opt.termguicolors = true

-- Files / swap
opt.swapfile = true
opt.backup = false
opt.undofile = true

-- Spelling
opt.spelllang = { "en_gb", "fr" }

-- Neovim compatibility
vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")

-- Enable conceal for Obsidian UIs, but only in markdown buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt.conceallevel = 2
  end,
})

