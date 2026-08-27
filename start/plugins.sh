#!/bin/zsh
for plugin ($plugins) {
    local plugin_path="$MYZSH_DIR/plugins/$plugin/$plugin.plugin.zsh"
    if [[ -f "$plugin_path" ]]; then
        source "$plugin_path"
    else
        echo "\033[31m[错误] 插件 \x1b[34;1m$plugin\033[0m\033[31m 不存在\033[0m" >&2
    fi
}