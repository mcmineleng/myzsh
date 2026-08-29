randombuild() {
    THEMES_DIR="$MYZSH_DIR/themes"
    OUTPUT_FILE="$MYZSH_DIR/config/themes/random/themes_list"
    
    [ ! -d "$THEMES_DIR" ] && return 1
    
    mkdir -p "$(dirname "$OUTPUT_FILE")" 2>/dev/null || return 1
    rm -f "$OUTPUT_FILE" 2>/dev/null
    
    cd "$THEMES_DIR" 2>/dev/null || return 1
    
    find . -maxdepth 1 -type f -name "*.zsh-theme" 2>/dev/null | \
        sed -e 's/^\.\///' -e 's/\.zsh-theme$//' | \
        sort -u > "$OUTPUT_FILE" 2>/dev/null || return 1
    
    [ -s "$OUTPUT_FILE" ] || return 1
    return 0
}

if [ ! -f "$MYZSH_DIR/config/themes/random/themes_list" ]; then
    randombuild || {
        ZSH_THEME="robbyrussell"
        source "${MYZSH_DIR}/themes/${ZSH_THEME}.zsh-theme" 2>/dev/null
        return
    }
fi

THEMES_LIST="$MYZSH_DIR/config/themes/random/themes_list"
if [ -f "$THEMES_LIST" ] && [ -s "$THEMES_LIST" ]; then
    LINE_NUMBER=$(wc -l < "$THEMES_LIST" 2>/dev/null)
    if [ "$LINE_NUMBER" -gt 0 ]; then
        THEME_NUMBER=$((RANDOM % LINE_NUMBER + 1))
        ZSH_THEME=$(sed -n "${THEME_NUMBER}p" "$THEMES_LIST" 2>/dev/null)
        if [ -n "$ZSH_THEME" ]; then
            THEME_FILE="${MYZSH_DIR}/themes/${ZSH_THEME}.zsh-theme"
            if [ -f "$THEME_FILE" ]; then
                source "$THEME_FILE" 2>/dev/null && return
            fi
        fi
    fi
fi

# 回退到默认主题
ZSH_THEME="default"
source "${MYZSH_DIR}/themes/${ZSH_THEME}.zsh-theme" 2>/dev/null