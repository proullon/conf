return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release
  cmd = {
    "Obsidian",
    "ObsidianToday",
    "ObsidianYesterday",
    "ObsidianTomorrow",
    "ObsidianNew",
    "ObsidianOpen",
    "ObsidianSearch",
    "ObsidianBacklinks",
  },
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  ---@type obsidian.config
  opts = {
    ---------------------------------------------------------------------------
    -- WORKSPACES (required)
    -- At least one workspace is mandatory. The path must point to the vault
    -- root (the directory containing the `.obsidian` folder).
    ---------------------------------------------------------------------------
    workspaces = {
      {
        name = "personal",
        path = vim.fn.expand("~/Obsidian"),
      },
    },

    ---------------------------------------------------------------------------
    -- NEW NOTES
    -- Determines where new notes are placed.
    -- "current_dir" = same directory as the active buffer.
    ---------------------------------------------------------------------------
    new_notes_location = "current_dir",

    ---------------------------------------------------------------------------
    -- DAILY NOTES
    ---------------------------------------------------------------------------
    daily_notes = {
      folder = "dailies",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
    },

    ---------------------------------------------------------------------------
    -- COMPLETION (nvim-cmp integration)
    ---------------------------------------------------------------------------
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    ---------------------------------------------------------------------------
    -- OPEN / URL HANDLING
    -- In the new config style, things like `use_advanced_uri` live here.
    ---------------------------------------------------------------------------
    open = {
      app = "xdg-open",         -- command used to open external URLs
      args = {},
      open_app_foreground = false,
      use_advanced_uri = false, -- moved here instead of top-level
    },

    ---------------------------------------------------------------------------
    -- FRONTMATTER
    -- Replaces the old `disable_frontmatter` / `note_frontmatter_func`.
    ---------------------------------------------------------------------------
    frontmatter = {
      enabled = true,

      -- Disable strict alias type checking
      validate = {
          alias = false,
      },

      -- Normalize frontmatter fields so that aliases etc. are always strings.
      -- Avoid issues with number only notes.
      func = function(note)
        local function normalize(v)
          if type(v) == "number" then
            return tostring(v)
          elseif type(v) == "string" then
            return v
          elseif type(v) == "table" then
            local out = {}
            for _, x in ipairs(v) do
              table.insert(out, normalize(x))
            end
            return out
          end
          return v
        end

        return {
          id = normalize(note.id),
          aliases = normalize(note.aliases),
          tags = note.tags,
      }
      end,
    },

    ---------------------------------------------------------------------------
    -- SEARCH
    -- Replaces deprecated top-level `sort_by` / `sort_reversed`.
    ---------------------------------------------------------------------------
    search = {
      sort_by = "modified",
      sort_reversed = true,
    },

    ---------------------------------------------------------------------------
    -- UI SETTINGS (checkboxes, bullets, highlights)
    -- New style replaces the old `ui.checkboxes` warnings.
    ---------------------------------------------------------------------------
    ui = {
      enable = true,
      update_debounce = 200,

      bullets = { char = "•" },
    },

    checkboxes = {
      -- Order that checkbox states cycle through
      order = { " ", "x", ">", "~" },

      [" "] = { char = "󰄱" },
      ["x"] = { char = "" },
      [">"] = { char = "" },
      ["~"] = { char = "󰰱" },
    },

    ---------------------------------------------------------------------------
    -- FINDER (Telescope / fzf / mini)
    ---------------------------------------------------------------------------
    finder = "telescope.nvim",

    finder_mappings = {
      new = "<C-x>", -- Create new note from query
    },

    ---------------------------------------------------------------------------
    -- LEGACY COMMANDS
    -- Disable old-style commands like :ObsidianBacklinks.
    ---------------------------------------------------------------------------
    legacy_commands = false,
  },
}
