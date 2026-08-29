_omz_source() {
#此为Oh-My-Zsh函数的fork的修改
  local context filepath="$1"

  # 1. 构造 zstyle 上下文（用于控制别名行为）
  case "$filepath" in
  lib/*) context="lib:${filepath:t:r}" ;;         # lib/git.zsh → lib:git
  plugins/*) context="plugins:${filepath:h:t}" ;; # plugins/git/git.plugin.zsh → plugins:git
  esac

  # 2. 检查是否禁用别名
  local disable_aliases=0
  zstyle -T ":omz:${context}" aliases || disable_aliases=1

  # 3. 备份当前别名（如果禁用别名）
  local -A aliases_pre galiases_pre
  if (( disable_aliases )); then
    aliases_pre=("${(@kv)aliases}")
    galiases_pre=("${(@kv)galiases}")
  fi

  # 4. 加载实际文件（优先自定义目录）
  if [[ -f "$MYZSH_DIR/$filepath" ]]; then
    source "$ZSH_CUSTOM/$filepath"

  # 5. 恢复或清理别名（如果禁用别名）
  if (( disable_aliases )); then
    if (( #aliases_pre )); then
      aliases=("${(@kv)aliases_pre}")
    else
      (( #aliases )) && unalias "${(@k)aliases}"
    fi
    if (( #galiases_pre )); then
      galiases=("${(@kv)galiases_pre}")
    else
      (( #galiases )) && unalias "${(@k)galiases}"
    fi
  fi
}
for lib_file ("$MYZSH_DIR"/lib/*.zsh); do
  _omz_source "lib/${lib_file:t}"
done
unset lib_file