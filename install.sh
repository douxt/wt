#!/bin/sh
set -e

INSTALL_DIR="${HOME}/.local/bin"
VERSION="1.0.0"
RAW_BASE="https://raw.githubusercontent.com/douxt/wt/v${VERSION}"

echo "=== wt ${VERSION} 安装 ==="
echo ""

mkdir -p "$INSTALL_DIR"

echo "⬇  下载 wt ${VERSION} ..."
curl -fsSL "${RAW_BASE}/wt" -o "$INSTALL_DIR/wt"
chmod +x "$INSTALL_DIR/wt"
echo "✅ wt → $INSTALL_DIR/wt"

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
