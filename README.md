# 快速开始                                                ### 前置依赖
> Python 3.8 +

> zsh

<br></br>
复制此条命令一键安装
```shell
(curl -O https://sh.mcleng.cn/myzshinstall || wget https://sh.mcleng.cn/myzshinstall) && bash myzshinstall --cli
```
<br></br>
安装一个好看的主题(推荐Powerlevel10k)
```shell
myzsh theme install powerlevel10k
```
```shell
myzsh theme set powerlevel10k/powerlevel10k
```
<br></br>
# 安装
### 前置依赖
> Python 3.8 +

> zsh
<br></br>
### 下载脚本
**使用curl**
```shell
curl -O https://sh.mcleng.cn/myzshinstall
```

**使用wget**
```shell
wget https://sh.mcleng.cn/myzshinstall
```
***

### 交互式安装
```shell
bash myzshinstall --cli
```
脚本会询问一些信息
```text
MyZsh仓库地址(回车默认):
Oh-My-Zsh仓库地址:
安装目录(默认~/.myzsh):
安装Oh-My-Zsh自带主题 [Y/n]: y
安装Oh-My-Zsh自带插件 [Y/n]: y
```
需要自定义目录的可以自行填写,不需要的也可以一路回车
***
### 非交互式安装
通过环境变量预设参数，实现非交互式安装。


#### 环境变量配置表

| 变量名 | 说明 | 默认值 |
|--------|------|--------|
| `OMZ_REPO` | Oh-My-Zsh 上游仓库地址，可配置镜像 | `https://github.com/ohmyzsh/ohmyzsh` |
| `MYZSH_REPO` | 本项目仓库地址，可配置镜像 | `https://github.com/mcmineleng/myzsh` |
| `MYZSH_DIR` | 安装路径 | `$HOME/.myzsh` |
| `OMZ_THEMES_INSTALL` | 是否安装 Oh-My-Zsh 内置主题集 | `true` |
| `OMZ_PLUGINS_INSTALL` | 是否安装 Oh-My-Zsh 内置插件集 | `true` |

***

**标准模式**（保留控制台输出便于日志审计）
```shell
bash myzshinstall
```

**静默模式**
```shell
bash myzshinstall > /dev/null
```
> \> /dev/null表示把标准输出给丢弃，会保留错误信息

***
## 手动安装
首先创建安装目录
```shell
mkdir -p ~/.myzsh
```
<br></br>
然后克隆仓库
```shell
git clone --depth 1 https://github.com/mcmineleng/myzsh ~/.myzsh
```
<br></br>
克隆Oh-My-Zsh
```shell
git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh ~/ohmyzsh
```
<br></br>
删除Oh-My-Zsh的random主题（我们已经包含了该主题，Oh-My-Zsh版本的random无法正常工作，需要我的MyZsh专用版本）
```shell
rm ~/ohmyzsh/themes/random.zsh-theme
```
<br></br>
复制Oh-My-Zsh内置主题至MyZsh
```shell
cp -r ~/ohmyzsh/themes ~/.myzsh
```
<br></br>
复制Oh-My-Zsh内置插件至MyZsh
```shell
cp -r ~/ohmyzsh/plugins ~/.myzsh
```
<br></br>
删除Oh-My-Zsh目录
```shell
rm -rf ~/ohmyzsh
```
<br></br>
备份原.zshrc(如有)
```shell
cp ~/.zshrc ~/.zshrc.bak
```
<br></br>
写入新配置
```shell
cat > ~/.zshrc << 'EOF'
MYZSH_DIR="$HOME/.myzsh"
source "$MYZSH_DIR/start/myzsh-load.sh"
EOF
```
<br></br>
重载配置
```shell
exec zsh
```
> 请勿使用 source ~/.zshrc 该命令无法完全重载配置，可能会 导致奇怪的问题，exec zsh会重启整个zsh# myzsh管理CLI

## 功能介绍

myzsh 用于管理已安装的主题和插件，包括：
- 切换主题
- 启用/禁用插件
- 编辑配置文件
- 设置编辑器

## 命令说明

### 主题管理

**设置主题**

```shell
myzsh theme set <主题名>
```

主题名需与 `~/.myzsh/themes/` 目录下的文件名一致。Oh-My-Zsh内置主题可以直接设置，安装的主题需要，主题安装名/具体文件(一般和主题安装名一致)

**设置主题配置文件**

```shell
myzsh theme config <路径>
```

指定主题的配置文件路径，用于自定义主题样式。

**列出已安装主题**

```shell
myzsh theme list
```

显示所有已安装的主题，当前使用的主题会以绿色星标突出显示。

### 插件管理

**交互式插件管理**

```shell
myzsh plugin
```

进入交互式界面，使用上下键选择插件，空格切换启用/禁用状态 ，Enter 确认保存，ESC 取消。

**启用插件**

```shell
myzsh plugin add <插件名1> [插件名2] ...
```

启用一个或多个已安装的插件。

**禁用插件**

```shell
myzsh plugin remove <插件名1> [插件名2] ...
```

禁用一个或多个已启用的插件。

**列出插件**

```shell
myzsh plugin list
```

列出所有已安装插件，未启用的显示为 ○，已启用的显示为 ●。

```shell
myzsh plugin list true
```

仅列出已启用的插件。

### 配置编辑

**编辑配置文件**

```shell
myzsh edit <路径>
```

编辑 `~/.myzsh/config/` 目录下的配置文件。路径相对于配置目录。

示例：
```shell
myzsh edit myzsh/theme
```

编辑主题设置。

```shell
myzsh edit myzsh/plugins
```

编辑插件列表。

```shell
myzsh edit custom/my.conf
```

编辑自定义配置文件。

**设置默认编辑器**

```shell
myzsh edit set <编辑器命令>
```

设置编辑配置文件时使用的编辑器。

示例：
```shell
myzsh edit set vim
```

```shell
myzsh edit set /usr/bin/nano
```

**查看帮助**

```shell
myzsh help
```# myzshpack包管理CLI

## 功能介绍

myzshpack 用于从在线仓库安装/移除主题和插件，支持：
- 多仓库源聚合
- 变量替换
- 手动安装（直接指定 URL）
- 环境变量覆盖

## 前置配置

### 仓库配置文件

位置：`~/.myzsh/config/myzshpack/packages_repo.json`

默认内容：
```json
{
  "repo": [
    {
      "name": "default",
      "index": "https://raw.github.com/mcmineleng/myzsh-package/main/index.json"
    }
  ]
}
```

可添加多个仓库源，索引会被自动合并去重。

### 环境变量配置

位置：`~/.myzsh/config/myzshpack/env`

格式示例：
```ini
[default]
# 最低优先级
REPO_BASE=https://github.com

[global]
# 全局配置，覆盖 index.json 的 env
REPO_BASE=https://github.com

[仓库名]
# 仓库特定配置，覆盖 global
REPO_BASE=https://gitee.com
```

#### 变量优先级（从低到高）

1. `[default]` - 最低优先级
2. index.json 中的 `env` 数组
3. `[global]` - 覆盖 index.json
4. `[仓库名]` - 覆盖 global
5. 预设变量 (`INDEX_BASE_URL`, `INDEX_DOMAIN`) - 最高优先 级

## 命令说明

### 更新索引

```shell
myzshpack update
```

从所有配置的仓库源拉取索引并合并。首次使用前必须先执行此命令。

### 安装

**从仓库安装**

```shell
myzshpack install <名称>
```

从仓库安装主题或插件。如果名称只匹配主题或插件，直接安装；如果两者都匹配，会询问选择。

**精确安装主题**

```shell
myzshpack install theme <名称>
```

**精确安装插件**

```shell
myzshpack install plugin <名称>
```

**手动安装（直接指定 URL）**

```shell
myzshpack install theme <URL> [类型]
```

安装主题，类型可选：git（默认）、zip、tar.gz、tar

```shell
myzshpack install plugin <URL> [类型]
```

安装插件，类型可选：git（默认）、zip、tar.gz、tar

示例：

```shell
myzshpack install theme https://github.com/romkatv/powerlevel10k.git
```

安装 Git 仓库主题。

```shell
myzshpack install plugin https://github.com/zsh-users/zsh-autosuggestions.git
```

安装 Git 仓库插件。

```shell
myzshpack install theme https://github.com/dracula/zsh/archive/master.zip zip
```

安装 ZIP 压缩包主题。

```shell
myzshpack install plugin https://github.com/sindresorhus/pure/archive/v1.0.0.tar.gz tar.gz
```

安装 tar.gz 压缩包插件。

### 移除

```shell
myzshpack remove <名称>
```

移除已安装的主题或插件。如果同名主题和插件都存在，会询问移除哪个。

**精确移除主题**

```shell
myzshpack remove theme <名称>
```

**精确移除插件**

```shell
myzshpack remove plugin <名称>
```

### 搜索

```shell
myzshpack search <关键词>
```

在索引中搜索匹配的主题和插件，显示详细信息包括 URL 和类型 。

### 列出可用包

```shell
myzshpack list
```

列出所有仓库中可用的主题和插件。

### 列出已安装包

```shell
myzshpack list installed
```

列出本地已安装的主题和插件。

### 查看帮助

```shell
myzshpack help
```

***

# 变量替换功能

index.json 中的 `url` 字段支持变量替换，格式为 `${VAR_NAME}`。

## index.json 示例

```json
{
  "env": [
    {"REPO_BASE": "https://github.com"},
    {"USER": "zsh-users"}
  ],
  "plugins": [
    {
      "id": "zsh-autosuggestions",
      "url": "https://${REPO_BASE}/${USER}/zsh-autosuggestions",
      "type": "git"
    }
  ]
}
```

## 预设变量

更新索引时会自动设置以下变量：
- `INDEX_BASE_URL` - 索引文件的完整 URL
- `INDEX_DOMAIN` - 索引文件的域名（包含协议头）

## 使用场景

通过环境变量可以灵活切换仓库源。

**env 配置示例：**

```ini
[default]
REPO_BASE=https://github.com

[mirror]
REPO_BASE=https://gitee.com
```

这样同一个 index.json 可以在不同环境下使用不同的仓库源，无需修改索引文件。

***

# 常见工作流

## 首次使用

```shell
myzshpack update
```

更新索引。

```shell
myzshpack list
```

查看可用包。

```shell
myzshpack install powerlevel10k
```

安装主题。

```shell
myzshpack install zsh-autosuggestions
```

安装插件。

```shell
myzshpack install zsh-syntax-highlighting
```

安装插件。

```shell
myzsh theme set powerlevel10k
```

设置主题。

```shell
myzsh plugin
```

交互式启用插件。

```shell
myzsh edit myzsh/theme_config
```

编辑主题配置（可选）。

## 日常使用

```shell
myzsh theme set spaceship
```

切换主题。

```shell
myzsh plugin
```

启用/禁用插件。

```shell
myzshpack install plugin git
```

安装新插件。

```shell
myzshpack update
```

更新包索引。

```shell
myzshpack search git
```

搜索包。

```shell
myzshpack remove old-theme
```

移除不需要的包