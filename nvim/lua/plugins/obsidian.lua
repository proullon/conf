return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = { "markdown" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<C-o>", "<cmd>ObsidianQuickSwitch<CR>", desc = "Obsidian Quick Switch" },
    },
    config = function()
      require("obsidian").setup({
        workspaces = {
          {
            name = "personal",
            path = "~/Obsidian",
          },
        },
        new_notes_location = "current_dir",
        log_level = vim.log.levels.INFO,
        daily_notes = {
          folder = "dailies",
          date_format = "%Y-%m-%d",
          alias_format = "%B %-d, %Y",
          template = nil,
        },
        completion = {
          nvim_cmp = true,
          min_chars = 2,
        },
        mappings = {
          ["gf"] = {
            action = function()
              return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
          ["<leader>ch"] = {
            action = function()
              return require("obsidian").util.toggle_checkbox()
            end,
            opts = { buffer = true },
          },
        },
        note_id_func = function(title)
          local suffix = ""
          if title ~= nil then
            suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
          else
            for _ = 1, 4 do
              suffix = suffix .. string.char(math.random(65, 90))
            end
          end
          return suffix
        end,
        note_path_func = function(spec)
          local path = spec.dir / tostring(spec.id)
          return path:with_suffix(".md")
        end,
        wiki_link_func = function(opts)
          return require("obsidian.util").wiki_link_id_prefix(opts)
        end,
        markdown_link_func = function(opts)
          return require("obsidian.util").markdown_link(opts)
        end,
        preferred_link_style = "markdown",
        disable_frontmatter = false,
        note_frontmatter_func = function(note)
          local out = { id = note.id, aliases = note.aliases, tags = note.tags }
          if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
              out[k] = v
            end
          end
          return out
        end,
        templates = {
          subdir = "templates",
          date_format = "%Y-%m-%d",
          time_format = "%H:%M",
          substitutions = {},
        },
        follow_url_func = function(url)
          vim.fn.jobstart({ "xdg-open", url })
        end,
        use_advanced_uri = false,
        open_notes_in = "vsplit",
        finder = "telescope.nvim",
        finder_mappings = {
          new = "<C-x>",
        },
        sort_by = "modified",
        sort_reversed = true,
        ui = {
          enable = true,
          update_debounce = 200,
          checkboxes = {
            [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
            ["x"] = { char = "", hl_group = "ObsidianDone" },
            [">"] = { char = "", hl_group = "ObsidianRightArrow" },
            ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
          },
          bullets = { char = "•", hl_group = "ObsidianBullet" },
          external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
          reference_text = { hl_group = "ObsidianRefText" },
          highlight_text = { hl_group = "ObsidianHighlightText" },
          tags = { hl_group = "ObsidianTag" },
          hl_groups = {
            ObsidianTodo = { bold = true, fg = "#f78c6c" },
            ObsidianDone = { bold = true, fg = "#89ddff" },
            ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
            ObsidianTilde = { bold = true, fg = "#ff5370" },
            ObsidianBullet = { bold = true, fg = "#89ddff" },
            ObsidianRefText = { underline = true, fg = "#c792ea" },
            ObsidianExtLinkIcon = { fg = "#c792ea" },
            ObsidianTag = { italic = true, fg = "#89ddff" },
            ObsidianHighlightText = { bg = "#75662e" },
          },
        },
        attachments = {
          img_folder = "assets/imgs",
          img_text_func = function(client, path)
            local vault_relative_path = client:vault_relative_path(path)
            local link_path = vault_relative_path ~= nil and vault_relative_path or tostring(path)
            local display_name = vim.fs.basename(link_path)
            return string.format("![%s](%s)", display_name, link_path)
          end,
        },
        yaml_parser = "native",
      })

      -- Markdown spelling
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.opt_local.spell = true
        end,
      })
    end,
  },
}

