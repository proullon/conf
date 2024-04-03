# Nushell Environment Config File

def create_left_prompt [] {
    let path_segment = ($env.PWD)

    $path_segment
}

def create_right_prompt [] {
    let time_segment = ([
        (date now | date format '%m/%d/%Y %r')
    ] | str join)

    $time_segment
}

# Use nushell functions to define your right and left prompt
# let-env PROMPT_COMMAND = { create_left_prompt }
# let-env PROMPT_COMMAND_RIGHT = { create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
# let-env PROMPT_INDICATOR = { "〉" }
# let-env PROMPT_INDICATOR_VI_INSERT = { ": " }
# let-env PROMPT_INDICATOR_VI_NORMAL = { "〉" }
# let-env PROMPT_MULTILINE_INDICATOR = { "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row ':' }
    to_string: { |v| $v | path expand | str join ':' }
  }
  "Path": {
    from_string: { |s| $s | split row '-' }
    to_string: { |v| $v | path expand | str join '-' }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/usr/bin')
$env.GPG_TTY = (echo (tty))

$env.TERM = xterm-256color
$env.EDITOR = nvim
$env.VISUAL = nvim

$env.NVIM_LISTEN_ADDRESS = /tmp/nvimsocket
$env.PATH = ($env.PATH | append ':/home/proullon/work/flutter/bin')
$env.PATH = ($env.PATH | append ':/home/proullon/work/android-studio/bin')
$env.PATH = ($env.PATH | append ':/home/proullon/work/cmdline-tools/bin')
$env.PATH = ($env.PATH | append ':/home/proullon/Android/Sdk/platform-tools')
$env.PATH = ($env.PATH | append ':/home/proullon/Android/Sdk/build-tools')
$env.PATH = ($env.PATH | append ':/usr/local/go/bin')
$env.PATH = ($env.PATH | append ':/home/proullon/go/bin')
$env.PATH = ($env.PATH | append ':/home/proullon/.foundry/bin')
$env.CHROME_EXECUTABLE = "/usr/bin/chromium"

################# Test oh-my-posh config
#oh-my-posh init nu
