# wt — 多仓库 Git Worktree 管理器

一键创建、提交、清理跨多个 Git 仓库的 worktree。

## 安装

### curl 一键安装

```bash
curl -fsSL https://gitee.com/cybxcoder/wt/raw/v1.0.0/install.sh | bash
```

> 可先 `curl url > install.sh && less install.sh` 审阅再执行。

### npm

```bash
npm install -g wt-multi-repo
```

## 卸载

```bash
# curl 安装
rm ~/.local/bin/wt ~/.wtconfig

# npm 安装
npm uninstall -g wt-multi-repo
```

## 配置

### `~/.wtconfig`（自动创建）

```bash
# wt 多仓库 worktree 管理器配置
WT_ROOT=$HOME/wt
```

首次运行 `wt` 时自动生成默认配置。

### `.wtrepos`（需手动创建）

在项目根目录创建 `.wtrepos`，每行一个仓库绝对路径：

```
/home/user/projects/my-frontend
/home/user/projects/my-backend
```

`#` 开头的行和空行被忽略。

## 命令

| 命令 | 说明 |
|------|------|
| `wt create <name> -m <描述>` | 创建跨仓库 worktree |
| `wt list` | 列出所有活跃任务 |
| `wt status <name>` | 查看任务各仓库状态 |
| `wt commit <name> "消息"` | 提交并推送所有仓库 |
| `wt rebase <name>` | 所有仓库 rebase 基础分支 |
| `wt cleanup <name> [--force]` | 清理 worktree |
| `wt doctor` | 检查残留 worktree |
| `wt update` | 更新 wt 到最新版 |
| `wt --version` | 查看版本 |

`commit` 额外选项：`--no-push`（只提交不推送）、`--amend`（追加到上次提交）。

## 示例

```bash
cd ~/projects/my-app
wt create fix-login -m "修复登录跳转"

# 进入 worktree 开发
cd ~/wt/my-app/fix-login/frontend

# 正常开发后提交
git add .
wt commit fix-login "fix: 修复登录跳转"

# 同步基础分支
wt rebase fix-login

# 合并到 master 后清理
wt cleanup fix-login
```

`-p` 从任意目录指定项目：

```bash
wt -p ~/projects/my-app status fix-login
```

## 依赖

- git
- bash 3.2+
- curl（仅 `update` 命令需要）
