***

# MyZSH 使用帮助
## 安装
使用curl
```
zsh <(curl -sSL https://raw.githubusercontent.com/mcmineleng/myzsh/main/install.sh) --cli
```
  
使用wget
```
zsh <(wget -qO- https://raw.githubusercontent.com/mcmineleng/myzsh/main/install.sh) --cli
```
## 用法
```shell
myzsh <命令> [参数]
```

***

## 命令

### `install` — 安装主题或插件
```
myzsh install <theme|plugin> <仓库地址>
```
- `theme`   — 安装主题
- `plugin`  — 安装插件

---

### `theme` — 主题管理
```
myzsh theme set <主题名>
```
```
myzsh theme config <路径>
```
- `set`     — 设置当前主题
- `config`  — 设置主题配置文件路径

---

### `plugin` — 插件管理
```
myzsh plugin add <插件名>...
```
```
myzsh plugin remove <插件名>...
```
```
myzsh plugin list
```
- `add`     — 启用已安装的插件（可添加多个）
- `remove`  — 移除已启用的插件（可移除多个）
- `list`    — 列出已启用的插件

---

### `edit` — 编辑配置文件
```
myzsh edit <路径>
```
```
myzsh edit set <编辑器命令>
```
- `<路径>`         — 编辑配置文件，路径相对于 `~/.local/share/myzsh/config/`
- `set`            — 设置默认编辑器（如 `vim`、`nano`、`/usr/bin/nano`）

---

### `help` — 显示帮助信息
```
myzsh help
```

---

## 配置文件加载目录
```
~/.local/share/myzsh/config/myzsh/
```
（该目录下的配置由 myzsh 实际加载）

---

## 配置文件示例
| 命令 | 说明 |
|------|------|
| `myzsh edit myzsh/theme` | 编辑主题设置 |
| `myzsh edit myzsh/theme_config` | 编辑主题配置文件路径 |
| `myzsh edit myzsh/plugins` | 编辑插件列表 |
| `myzsh edit myzsh/edit` | 编辑编辑器设置 |
| `myzsh edit custom/my.conf` | 编辑自定义配置文件 |

---

## 示例
```
myzsh install theme https://github.com/user/theme-repo.git
```

```
myzsh install plugin https://github.com/user/plugin-repo.git
```

```
myzsh theme set mytheme
```

```
myzsh theme config /path/to/theme.config
```

```
myzsh plugin add git zsh-autosuggestions
```

```text
myzsh plugin remove git
```

```
myzsh plugin list
```

```
myzsh edit myzsh/plugins
```

```
myzsh edit myzsh/theme
```

```
myzsh edit set vim
```

```
myzsh edit set /usr/bin/nano
```

```
myzsh edit custom/myconfig.conf
```
