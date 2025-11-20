set encoding=UTF-8          " This is the future...
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set wildmode=longest,list   " get bash-like tab completions
set autoread                " reload file modified outside of nvim automatically
filetype plugin indent on   " allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
" set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download
" language package)
" " set noswapfile            " disable creating swap file
" " set backupdir=~/.cache/vim " Directory to store backup files.

" My Awnesome conf !
" Nice colorscheme
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_build_constraints = 1

" enable pasting from clipboard
set mouse=r

" remap exiting from terminal with Esc
noremap <Esc> <C-\><C-n>

" I want small tabs
set tabstop=2
set softtabstop=2
set expandtab

" I want line number
set number

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" What do I want ?
" - Colorscheme matching tmux, etc: nightfox with duskfox variation.
" - Modern icons: vim-devicons and nvim-web-devicons
" - LSP, DAP, linters and formatters for each language I use: mason
" - Git integration: gitsigns, fugitive
" - Status bar: feline
" - Latex integration: vimtex
" - File navitagion: Telescope
"
" any language specific plugin should go in favor of mason

call plug#begin("~/.vim/plugged")
 " Theme
 Plug 'EdenEast/nightfox.nvim'
 " Icons
 Plug 'kyazdani42/nvim-web-devicons'
 Plug 'ryanoasis/vim-devicons'
 " Mason
 Plug 'williamboman/mason.nvim'
 Plug 'williamboman/mason-lspconfig.nvim'
 Plug 'williamboman/nvim-lspconfig'
 Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
 Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
 Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
 Plug 'L3MON4D3/LuaSnip' " Snippets plugin
 " Git
 Plug 'tpope/vim-fugitive'
 Plug 'lewis6991/gitsigns.nvim'
 " Status bar
 Plug 'feline-nvim/feline.nvim'
 " vimtex plugin for latex
 Plug 'lervag/vimtex'
 " Telescope
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim'
 Plug 'davvid/telescope-git-grep.nvim'
 " Flutter
 Plug 'stevearc/dressing.nvim' " optional for vim.ui.select
 Plug 'akinsho/flutter-tools.nvim'
 " Obsidian
 Plug 'epwalsh/obsidian.nvim'
 " File explorer tree view
 Plug 'MunifTanjim/nui.nvim'
 Plug 'nvim-neo-tree/neo-tree.nvim'
 " LLM
 "Plug 'David-Kunz/gen.nvim'
 "Plug 'jackMort/ChatGPT.nvim'
 Plug '/home/proullon/work/src/github.com/proullon/alex'
call plug#end()

" Nightfox colorschemes
colorscheme duskfox

" Map Ctrl-A -> Start of line, Ctrl-E -> End of line
inoremap <C-a> <Home>
inoremap <C-e> <End>
" Map Ctrl-P to Telescope find_files in normal mode
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-g> <cmd>Telescope git_grep<cr>
nnoremap <C-o> <cmd>ObsidianQuickSwitch<cr>

" Spelling
autocmd FileType markdown setlocal spell
autocmd FileType latex setlocal spell
set spelllang=en_gb,fr
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Vimtex config
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_view_general_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
let g:rustfmt_autosave = 1

command! AlexReload lua package.loaded["alex"]=nil; package.loaded["alex.chat"]=nil; require("alex").setup({
      \ endpoint = "http://127.0.0.1:8080/chat"
      \ })


lua << END
-- Start git setup in status bbar
require('gitsigns').setup()
-- Start status bar
require('feline').setup({
    preset = 'noicon'
})
require('mason').setup()
--require('mason-lspconfig').setup {
--    ensure_installed = { "lua_ls", "rust_analyzer", "gopls", "golangci_lint_ls", "ast_grep", "pyre" },
--}
require('mason-lspconfig').setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "gopls", "golangci_lint_ls" },
}

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')


-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- local servers = { 'rust_analyzer', 'gopls', 'golangci_lint_ls' }
local servers = { 'rust_analyzer', 'gopls', 'golangci_lint_ls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end


lspconfig.rust_analyzer.setup({
--    on_attach = function(client, bufnr)
--        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
--    end,

    on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

        -- Format à la sauvegarde
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
        styleLints = {
          enable = true,
        }
      },
      rustfmt = {
        extraArgs = {
          "+nightly",
          "--config", "format_code_in_doc_comments=true",
          "--config", "edition=2024"
        }
      },
      check = {
        command = "clippy",
        extraArgs = { "--", "-Wclippy::pedantic", "-Aclippy::redundant_else", "-Aclippy::too_many_lines" },
      },
      checkOnSave = true,
      rustc = {
        source = "discover"
      },
      assist = {
        importPrefix = "crate"
      },
      cargo = {
        autoreload = true
      },
      diagnostics = {
        enable = true,
        enableExperimental = true,
      },
      cargo = {
        allTargets = false,                       -- don’t build tests/examples by default
        extraEnv = { CARGO_BUILD_JOBS = "4" },    -- limit parallel jobs (use a number you like)
        buildScripts = {
            enable = true, -- try true; set to false if spikes persist
            -- this tells rust-analyzer to pass `-j4` to cargo (replace 4 with what you want)
            numJobs = 4,
            },
      },
      -- Avoid scanning huge dirs
      files = {
        excludeDirs = { "target", "node_modules", "dist", "build", ".venv", ".git" },
        -- watcher = "client", -- Uncomment if your setup supports client-side watching
      },
    },
  },
})


-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

--require('gen').setup({
--        model = "mistral", -- The default model to use.
--        quit_map = "q", -- set keymap to close the response window
--        retry_map = "<c-r>", -- set keymap to re-send the current prompt
--        accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
--        host = "localhost", -- The host running the Ollama service.
--        port = "11434", -- The port on which the Ollama service is listening.
--        display_mode = "split", -- The display mode. Can be "float" or "split" or "horizontal-split".
--        show_prompt = true, -- Shows the prompt submitted to Ollama.
--        show_model = true, -- Displays which model you are using at the beginning of your chat session.
--        no_auto_close = false, -- Never closes the window automatically.
--        file = false, -- Write the payload to a temporary file to keep the command short.
--        hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
--        init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
--        -- Function to initialize Ollama
--        command = function(options)
--            local body = {model = options.model, stream = true}
--            return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
--        end,
        -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
        -- This can also be a command string.
        -- The executed command must return a JSON object with { response, context }
        -- (context property is optional).
        -- list_models = '<omitted lua function>', -- Retrieves a list of model names
--        debug = false -- Prints errors and the command which is run.
--})

--require("chatgpt").setup({
--    api_key_cmd = "cat /home/proullon/.config/openai/key"
--})

require("alex").setup({
    endpoint = "http://127.0.0.1:8080/chat"
})

require('telescope').setup{
  defaults = {
    file_ignore_patterns = {
        "vendor/"
    },

    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
require("flutter-tools").setup {} -- use defaults
require("obsidian").setup(
{
  -- A list of vault names and paths.
  -- Each path should be the path to the vault root. If you use the Obsidian app,
  -- the vault root is the parent directory of the `.obsidian` folder.
  -- You can also provide configuration overrides for each workspace through the `overrides` field.
  workspaces = {
    {
      name = "personal",
      path = "~/Obsidian",
    },
  },

  -- Where to put new notes created from completion. Valid options are
  --  * "current_dir" - put new notes in same directory as the current buffer.
  --  * "notes_subdir" - put new notes in the default notes subdirectory.
  new_notes_location = "current_dir",

  -- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
  -- levels defined by "vim.log.levels.*".
  log_level = vim.log.levels.INFO,

  daily_notes = {
    -- Optional, if you keep daily notes in a separate directory.
    folder = "dailies",
    -- Optional, if you want to change the date format for the ID of daily notes.
    date_format = "%Y-%m-%d",
    -- Optional, if you want to change the date format of the default alias of daily notes.
    alias_format = "%B %-d, %Y",
    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
    template = nil
  },

  -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
  completion = {
    -- Set to false to disable completion.
    nvim_cmp = true,

    -- Trigger completion at 2 chars.
    min_chars = 2,
  },

  -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
  -- way then set 'mappings = {}'.
  mappings = {
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    ["gf"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    -- Toggle check-boxes.
    ["<leader>ch"] = {
      action = function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
  },

  -- Optional, customize how names/IDs for new notes are created.
  note_id_func = function(title)
    local suffix = ""
    if title ~= nil then
      -- If title is given, transform it into valid file name.
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      -- If title is nil, just add 4 random uppercase letters to the suffix.
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return suffix
  end,

  -- Optional, customize how note file names are generated given the ID, target directory, and title.
  ---@param spec { id: string, dir: obsidian.Path, title: string|? }
  ---@return string|obsidian.Path The full path to the new note.
  note_path_func = function(spec)
    -- This is equivalent to the default behavior.
    local path = spec.dir / tostring(spec.id)
    return path:with_suffix(".md")
  end,

  -- Optional, customize how wiki links are formatted. You can set this to one of:
  --  * "use_alias_only", e.g. '[[Foo Bar]]'
  --  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
  --  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
  --  * "use_path_only", e.g. '[[foo-bar.md]]'
  -- Or you can set it to a function that takes a table of options and returns a string, like this:
  wiki_link_func = function(opts)
    return require("obsidian.util").wiki_link_id_prefix(opts)
  end,

  -- Optional, customize how markdown links are formatted.
  markdown_link_func = function(opts)
    return require("obsidian.util").markdown_link(opts)
  end,

  -- Either 'wiki' or 'markdown'.
  preferred_link_style = "markdown",

  -- Optional, boolean or a function that takes a filename and returns a boolean.
  -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
  disable_frontmatter = false,

  -- Optional, alternatively you can customize the frontmatter data.
  note_frontmatter_func = function(note)
    -- This is equivalent to the default frontmatter function.
    local out = { id = note.id, aliases = note.aliases, tags = note.tags }
    -- `note.metadata` contains any manually added fields in the frontmatter.
    -- So here we just make sure those fields are kept in the frontmatter.
    if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
      for k, v in pairs(note.metadata) do
        out[k] = v
      end
    end
    return out
  end,

  -- Optional, for templates (see below).
  templates = {
    subdir = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
    -- A map for custom variables, the key should be the variable and the value a function
    substitutions = {},
  },

  -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
  -- URL it will be ignored but you can customize this behavior here.
  follow_url_func = function(url)
    -- Open the URL in the default web browser.
    vim.fn.jobstart({"open", url})  -- Mac OS
    -- vim.fn.jobstart({"xdg-open", url})  -- linux
  end,

  -- Optional, set to true if you use the Obsidian Advanced URI plugin.
  -- https://github.com/Vinzent03/obsidian-advanced-uri
  use_advanced_uri = false,

  -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
  open_app_foreground = false,

  -- Optional, by default commands like `:ObsidianSearch` will attempt to use
  -- telescope.nvim, fzf-lua, fzf.vim, or mini.pick (in that order), and use the
  -- first one they find. You can set this option to tell obsidian.nvim to always use this
  -- finder.
  finder = "telescope.nvim",

  -- Optional, configure key mappings for the finder. These are the defaults.
  -- If you don't want to set any mappings this way then set
  finder_mappings = {
    -- Create a new note from your query with `:ObsidianSearch` and `:ObsidianQuickSwitch`.
    -- Currently only telescope supports this.
    new = "<C-x>",
  },

  -- Optional, sort search results by "path", "modified", "accessed", or "created".
  -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
  -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
  sort_by = "modified",
  sort_reversed = true,

  -- Optional, determines how certain commands open notes. The valid options are:
  -- 1. "current" (the default) - to always open in the current window
  -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
  -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
  open_notes_in = "vsplit",

  -- Optional, configure additional syntax highlighting / extmarks.
  -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
  ui = {
    enable = true,  -- set to false to disable all additional syntax features
    update_debounce = 200,  -- update delay after a text change (in milliseconds)
    -- Define how various check-boxes are displayed
    checkboxes = {
      -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
      [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
      ["x"] = { char = "", hl_group = "ObsidianDone" },
      [">"] = { char = "", hl_group = "ObsidianRightArrow" },
      ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
      -- Replace the above with this if you don't have a patched font:
      -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
      -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

      -- You can also add more custom ones...
    },
    -- Use bullet marks for non-checkbox lists.
    bullets = { char = "•", hl_group = "ObsidianBullet" },
    external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    -- Replace the above with this if you don't have a patched font:
    -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    reference_text = { hl_group = "ObsidianRefText" },
    highlight_text = { hl_group = "ObsidianHighlightText" },
    tags = { hl_group = "ObsidianTag" },
    hl_groups = {
      -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
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

  -- Specify how to handle attachments.
  attachments = {
    -- The default folder to place images in via `:ObsidianPasteImg`.
    -- If this is a relative path it will be interpreted as relative to the vault root.
    -- You can always override this per image by passing a full path to the command instead of just a filename.
    img_folder = "assets/imgs",  -- This is the default
    -- A function that determines the text to insert in the note when pasting an image.
    -- It takes two arguments, the `obsidian.Client` and a plenary `Path` to the image file.
    -- This is the default implementation.
    ---@param client obsidian.Client
    ---@param path Path the absolute path to the image file
    ---@return string
    img_text_func = function(client, path)
      local link_path
      local vault_relative_path = client:vault_relative_path(path)
      if vault_relative_path ~= nil then
        -- Use relative path if the image is saved in the vault dir.
        link_path = vault_relative_path
      else
        -- Otherwise use the absolute path.
        link_path = tostring(path)
      end
      local display_name = vim.fs.basename(link_path)
      return string.format("![%s](%s)", display_name, link_path)
    end,
  },

  -- Optional, set the YAML parser to use. The valid options are:
  --  * "native" - uses a pure Lua parser that's fast but potentially misses some edge cases.
  --  * "yq" - uses the command-line tool yq (https://github.com/mikefarah/yq), which is more robust
  --    but much slower and needs to be installed separately.
  -- In general you should be using the native parser unless you run into a bug with it, in which
  -- case you can temporarily switch to the "yq" parser until the bug is fixed.
  yaml_parser = "native",
}
)
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

vim.api.nvim_create_user_command('GPT', function(opts)
  local prompt = opts.args
  local handle = io.popen("gpt " .. vim.fn.shellescape(prompt))
  local result = handle:read("*a")
  handle:close()
  print(result)
end, { nargs = 1, complete = 'file' })


END
