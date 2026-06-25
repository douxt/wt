#!/bin/sh
set -e

INSTALL_DIR="${HOME}/.local/bin"
VERSION="1.1.0"
GITHUB="https://raw.githubusercontent.com/douxt/wt/v${VERSION}"
GITEE="https://gitee.com/cybxcoder/wt/raw/v${VERSION}"

echo "=== wt ${VERSION} 安装 ==="
echo ""

mkdir -p "$INSTALL_DIR"

echo "⬇ 下载 wt ${VERSION} ..."
if ! curl -fsSL "${GITHUB}/wt" -o "$INSTALL_DIR/wt" 2>/dev/null; then
  echo "   GitHub 连接失败，尝试 Gitee ..."
  curl -fsSL "${GITEE}/wt" -o "$INSTALL_DIR/wt" || {
    echo "❌ 下载失败，请检查网络"; exit 1
  }
fi
chmod +x "$INSTALL_DIR/wt"
echo "✅ wt → $INSTALL_DIR/wt"

echo "⬇ 下载 wt-dev ${VERSION} ..."
if ! curl -fsSL "${GITHUB}/wt-dev" -o "$INSTALL_DIR/wt-dev" 2>/dev/null; then
  echo "   GitHub 连接失败，尝试 Gitee ..."
  curl -fsSL "${GITEE}/wt-dev" -o "$INSTALL_DIR/wt-dev" || {
    echo "❌ 下载失败，请检查网络"; exit 1
  }
fi
chmod +x "$INSTALL_DIR/wt-dev"
echo "✅ wt-dev → $INSTALL_DIR/wt-dev"

if [ ! -f "$HOME/.wtconfig" ]; then
  cat > "$HOME/.wtconfig" << 'EOF'
# wt 多仓库 worktree 管理器配置
WT_ROOT=$HOME/wt
EOF
  echo "✅ 已创建 ~/.wtconfig"
fi

if ! echo "$PATH" | tr ':' '\n' | grep -qxF "$INSTALL_DIR"; then
  echo ""
  echo "⚠️  $INSTALL_DIR 不在 PATH 中"
  echo "   请将以下行添加到 ~/.bashrc 或 ~/.zshrc："
  echo ""
  echo "   export PATH=\"$INSTALL_DIR:\$PATH\""
  echo ""
fi

echo ""
echo "✅ 安装完成！运行 wt --version 验证"
