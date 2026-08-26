#!/bin/zsh
source "$XDG_DATA_HOME/myzsh/lib/zsh-defer.plugin.zsh"
fpath+=($XDG_DATA_HOME/myzsh/lib $XDG_DATA_HOME/myzsh/bin)
autoload -Uz myzsh
source "$XDG_DATA_HOME/myzsh/start/autoload.sh"
source "$XDG_DATA_HOME/myzsh/start/function.sh"
source "$XDG_DATA_HOME/myzsh/config/myzsh/ZSH_THEME"
source "$XDG_DATA_HOME/myzsh/config/myzsh/ZSH_THEME_CONFIG"
source "$XDG_DATA_HOME/myzsh/start/theme.sh"
source "$XDG_DATA_HOME/myzsh/config/myzsh/HISTFILE"
source "$XDG_DATA_HOME/myzsh/start/history.sh"
source "$XDG_DATA_HOME/myzsh/start/alias.sh"
source "$XDG_DATA_HOME/myzsh/config/myzsh/plugins"
zsh-defer source "$XDG_DATA_HOME/myzsh/start/plugins.sh"