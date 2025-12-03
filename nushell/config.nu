# ============================================
# Nushell Unified Config for 0.107 → 0.109
# ============================================

# ---------- THEME ----------
let dark_theme = {
    separator: white
    leading_trailing_space_bg: { attr: n }
    header: green_bold
    empty: blue

    bool: {|| if $in { 'light_cyan' } else { 'light_gray' } }
    int: white
    float: white
    filesize: {|e|
      if $e == 0b { 'white' } else { 'blue' }
    }
    duration: white
    date: {|| (date now) - $in |
      if $in < 1hr { 'purple' }
      else if $in < 6hr { 'red' }
      else if $in < 1day { 'yellow' }
      else if $in < 3day { 'green' }
      else if $in < 1wk { 'light_green' }
      else if $in < 6wk { 'cyan' }
      else if $in < 52wk { 'blue' }
      else { 'dark_gray' }
    }
    nothing: white
    string: white
    list: white
    record: white
    binary: white

    shape_and: purple_bold
    shape_binary: purple_bold
    shape_block: blue_bold
    shape_bool: light_cyan
    shape_closure: green_bold
    shape_custom: green
    shape_datetime: cyan_bold
    shape_directory: cyan
    shape_external: cyan
    shape_externalarg: green_bold
    shape_filepath: cyan
    shape_flag: blue_bold
    shape_float: purple_bold
    shape_garbage: { fg: white bg: red attr: b}
    shape_globpattern: cyan_bold
    shape_int: purple_bold
    shape_internalcall: cyan_bold
    shape_list: cyan_bold
    shape_literal: blue
    shape_match_pattern: green
    shape_matching_brackets: { attr: u }
    shape_operator: yellow
    shape_or: purple_bold
    shape_pipe: purple_bold
    shape_range: yellow_bold
    shape_record: cyan_bold
    shape_redirection: purple_bold
    shape_signature: green_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_table: blue_bold
    shape_variable: purple
    shape_vardecl: purple
}

# ---------- APPLY THEME ----------
# Required for Nushell >= 0.108, safe for older versions
$env.config = (
    $env.config
    | upsert color_config $dark_theme
)

# ---------- CORE CONFIG ----------
$env.config = (
    $env.config
    | merge {
        show_banner: false
        edit_mode: "vi"
        use_ansi_coloring: true
        render_right_prompt_on_last_line: false
    }
)

# ---------- MENUS ----------
$env.config = (
  $env.config
  | upsert menus [
      {
        name: completion_menu
        only_buffer_difference: false
        marker: "| "
        type: { layout: columnar, columns: 4, col_padding: 2 }
        style: { text: green, selected_text: green_reverse }
      }
      {
        name: history_menu
        only_buffer_difference: true
        marker: "? "
        type: { layout: list, page_size: 10 }
        style: { text: green, selected_text: green_reverse }
      }
  ]
)

# ---------- KEYBINDINGS ----------
$env.config = (
  $env.config
  | upsert keybindings [
      {
        name: completion_menu
        modifier: none
        keycode: tab
        mode: [emacs, vi_normal, vi_insert]
        event: { until: [{ send: menu name: completion_menu }, { send: menunext }] }
      }
      {
        name: history_menu
        modifier: control
        keycode: char_r
        mode: emacs
        event: { send: menu name: history_menu }
      }
  ]
)

# ---------- LOAD OTHER CONFIG FILES ----------
source ~/.config/nushell/git-completions.nu
source ~/.config/nushell/alias.nu
source ~/.config/nushell/oh-my-posh.nu

# ---------- ENV STUFF ----------
source $"($nu.home-path)/.cargo/env.nu"

# Ensures PATH and conversions work everywhere
$env.ENV_CONVERSIONS = {
  PATH: {
    from_string: { |s| $s | split row ':' }
    to_string: { |v| $v | path expand | str join ':' }
  }
}

# Lib dirs
$env.NU_LIB_DIRS = [ ($nu.config-path | path dirname | path join 'scripts') ]
$env.NU_PLUGIN_DIRS = [ ($nu.config-path | path dirname | path join 'plugins') ]

# Terminal / editors
$env.TERM = "xterm-256color"
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

# PATH additions (cleaned)
$env.PATH = ($env.PATH | append [
    "/home/proullon/work/flutter/bin"
    "/home/proullon/work/android-studio/bin"
    "/home/proullon/work/cmdline-tools/bin"
    "/home/proullon/Android/Sdk/platform-tools"
    "/home/proullon/Android/Sdk/build-tools"
    "/usr/local/go/bin"
    "/home/proullon/go/bin"
    "/home/proullon/.foundry/bin"
    "/home/proullon/.local/bin"
    "/home/proullon/Android/Sdk/cmdline-tools/latest/bin"
])

# GPG Fix
$env.GPG_TTY = (tty)

# OpenAI
$env.OPENAI_API_KEY = (open ~/.config/openai/key | str trim)

# Chromium override
$env.CHROME_EXECUTABLE = "/usr/bin/chromium"

# Weird bug fix on prompt
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
