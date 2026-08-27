# 加载主题配置文件
if [[ -n "$ZSH_THEME_CONFIG" ]]; then
    if [[ -f "$ZSH_THEME_CONFIG" ]]; then
        source "$ZSH_THEME_CONFIG"
    else
        echo "\033[31m[错误] 主题配置 \x1b[34;1m$ZSH_THEME_CONFIG\033[0m\033[31m 不存在\033[0m"
    fi
fi

# 加载主题文件
if [[ -n "$ZSH_THEME" ]]; then
    if [[ -f "$MYZSH_DIR/themes/$ZSH_THEME.zsh-theme" ]]; then
        source "$MYZSH_DIR/themes/$ZSH_THEME.zsh-theme"
    else
        echo "\033[31m[错误] 主题 \x1b[34;1m$ZSH_THEME\033[0m\033[31m 不存在\033[0m"
    fi
fi