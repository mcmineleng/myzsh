#!/bin/bash
set -euo pipefail

# ===== 颜色定义 =====
readonly RED='\033[31m'
readonly GREEN='\033[32m'
readonly BLUE='\033[94m'
readonly RESET='\033[0m'

# ===== 标准日志函数 =====
log_info() {
    echo -e "[${GREEN}信息${RESET}] $*"
}

log_warn() {
    echo -e "[${BLUE}警告${RESET}] $*" >&2
}

log_error() {
    echo -e "[${RED}错误${RESET}] $*" >&2
}

# ===== 错误退出函数 =====
die() {
    log_error "$1"
    exit "${2:-1}"
}

# ===== 环境变量 =====
env() {
    OMZ_REPO="${MYZSH_REPO:-https://github.com/ohmyzsh/ohmyzsh}"
    MYZSH_REPO="${MYZSH_REPO:-https://github.com/mcmineleng/myzsh}"
    MYZSH_DIR="${MYZSH_DIR:-$HOME/.myzsh}"
    OMZ_THEMES_INSTALL="${OMZ_THEMES_INSTALL:-true}"
    OMZ_PLUGINS_INSTALL="${OMZ_PLUGINS_INSTALL:-true}"
}

# ===== 交互式配置 =====
cli() {
    read -p "\033[94mMyZsh仓库地址(回车默认): \033[0m" MYZSH_REPO
    read -p "\033[94mOh-My-Zsh仓库地址: \033[0m" OMZ_REPO
    read -p "\033[94m安装目录(默认\033[32m~/.myzsh\033[94m): \033[0m" MYZSH_DIR
    
    read -p "安装Oh-My-Zsh自带主题 [\033[32mY\033[94m/\033[31mn\033[94m] \033[0m" omz_install_themes
    omz_install_themes=${omz_install_themes:-Y}
    if [[ "$omz_install_themes" =~ ^[Yy]$ ]]; then
        OMZ_THEMES_INSTALL=true
    else
        OMZ_THEMES_INSTALL=false
    fi

    read -p "\033[94m安装Oh-My-Zsh自带插件 [\033[32mY\033[94m/\033[31mn\033[94m] \033[0m" omz_install_plugins
    omz_install_plugins=${omz_install_plugins:-Y}
    if [[ "$omz_install_plugins" =~ ^[Yy]$ ]]; then
        OMZ_PLUGINS_INSTALL=true
    else
        OMZ_PLUGINS_INSTALL=false
    fi
}

# ===== 安装 MyZsh =====
myzsh_install() {
    mkdir -p "$MYZSH_DIR" || die "安装目录创建失败: $MYZSH_DIR"
    log_info "安装目录创建成功"
    
    log_info "正在克隆 MyZsh 仓库 · · ·"
    git clone --depth 1 "$MYZSH_REPO" "$MYZSH_DIR" || die "克隆 MyZsh 仓库失败"
    log_info "克隆 MyZsh 仓库成功"
    log_info "正在授予myzsh执行权限"
    chmod +x  $MYZSH_DIR/bin/myzsh || die "授予执行权限失败"
    log_info "正在授予myzshpack执行权限"
    chmod +x  $MYZSH_DIR/bin/myzshpack || die "授予执行权限失败"
}

# ===== 克隆 Oh-My-Zsh =====
omz_clone() {
    mkdir -p "$MYZSH_DIR/.temp" || die "临时目录创建失败"
    log_info "临时目录创建成功"
    
    log_info "正在克隆 Oh-My-Zsh 仓库 · · ·"
    git clone --depth 1 "$OMZ_REPO" "$MYZSH_DIR/.temp/oh-my-zsh" || die "克隆 Oh-My-Zsh 仓库失败"
    log_info "克隆 Oh-My-Zsh 仓库成功"
}

# ===== 安装主题 =====
omz_themes_install() {
    log_info "正在复制主题目录"
    if [[ -f "$MYZSH_DIR/.temp/oh-my-zsh/themes/random.zsh-theme" ]]; then
        rm "$MYZSH_DIR/.temp/oh-my-zsh/themes/random.zsh-theme"
    fi
    cp -r "$MYZSH_DIR/.temp/oh-my-zsh/themes" "$MYZSH_DIR/" || die "主题目录复制失败"
    log_info "主题目录复制成功"
}

# ===== 安装插件 =====
omz_plugins_install() {
    cp -r "$MYZSH_DIR/.temp/oh-my-zsh/plugins" "$MYZSH_DIR/" || die "插件目录复制失败"
    log_info "插件目录复制成功"
}

# ===== 写入 zshrc =====
write_zshrc() {
    if [ ! -f ~/.zshrc ]; then
        touch ~/.zshrc || die "~/.zshrc 创建失败"
        log_info "~/.zshrc 创建成功"
    fi

    cat >> ~/.zshrc << 'EOF'

MYZSH_DIR="$HOME/.myzsh"
source "$MYZSH_DIR/start/myzsh-load.sh"
EOF

    if [ $? -eq 0 ]; then
        log_info "~/.zshrc 写入成功"
    else
        log_error "~/.zshrc 写入失败"
        cat << 'MANUAL' >&2
请手动将以下配置加入 ~/.zshrc：

MYZSH_DIR="$HOME/.myzsh"
source "$MYZSH_DIR/start/myzsh-load.sh"
MANUAL
        exit 1
    fi
}

# ===== 清理临时目录 =====
temp_clear() {
    log_info "正在清理临时目录"
    rm -rf "$MYZSH_DIR/.temp" || die "临时目录清理失败"
    log_info "临时目录清理成功"
}

# ===== 主函数 =====
main() {
    if ! command -v git &> /dev/null; then
        die "Git 未安装，请安装之后继续"
    fi
    
    if [[ " $* " == *" --cli "* ]]; then
        cli
    fi
    
    env
    myzsh_install
    
    if [[ "$OMZ_THEMES_INSTALL" == "true" ]] || [[ "$OMZ_PLUGINS_INSTALL" == "true" ]]; then
        omz_clone
    fi
    
    if [[ "$OMZ_THEMES_INSTALL" == "true" ]]; then
        omz_themes_install
    fi
    
    if [[ "$OMZ_PLUGINS_INSTALL" == "true" ]]; then
        omz_plugins_install
    fi
    
    write_zshrc
    temp_clear
    
    echo ""
    log_info "安装完成！请使用以下命令重启 Zsh："
    echo "  exec zsh"
    echo "  或重新打开终端"
}

main "$@"