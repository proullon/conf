return {
  -- Telescope (fuzzy finder)
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<C-g>", "<cmd>Telescope git_grep<CR>", desc = "Git grep" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "davvid/telescope-git-grep.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          file_ignore_patterns = { "vendor/" },
          mappings = {
            i = {
              ["<C-h>"] = "which_key",
            },
          },
        },
      })
      telescope.load_extension("git_grep")
    end,
  },

  -- Neo-tree (file explorer)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle Neo-tree" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({})
    end,
  },
}

