#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════════╗
# ║  Ahtasham's Advanced ZSH Dotfiles Installer                       ║
# ║  Works on: GitHub Codespaces, macOS (VS Code Insiders), Linux      ║
# ╚══════════════════════════════════════════════════════════════════════╝

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Starting Advanced ZSH setup..."
echo "   OS: $(uname -s) | User: $(whoami)"

# ─── Detect Environment ──────────────────────────────────────────────────────
IS_CODESPACE=false
IS_MACOS=false

if [ -n "$CODESPACES" ] || [ -n "$CLOUDENV_ENVIRONMENT_ID" ]; then
    IS_CODESPACE=true
    echo "☁️  Detected: GitHub Codespace"
elif [[ "$(uname -s)" == "Darwin" ]]; then
    IS_MACOS=true
    echo "🍎 Detected: macOS"
else
    echo "🐧 Detected: Linux"
fi

# ─── Phase 1: Install Oh My Zsh ─────────────────────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "📦 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✅ Oh My Zsh already installed"
fi

# ─── Phase 2: Install Powerlevel10k Theme ────────────────────────────────────
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
    echo "🎨 Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
    echo "✅ Powerlevel10k already installed"
fi

# ─── Phase 3: Install Plugins ───────────────────────────────────────────────
PLUGINS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
    echo "💡 Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_DIR/zsh-autosuggestions"
else
    echo "✅ zsh-autosuggestions already installed"
fi

if [ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    echo "🌈 Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGINS_DIR/zsh-syntax-highlighting"
else
    echo "✅ zsh-syntax-highlighting already installed"
fi

# ─── Phase 4: Copy Config Files ─────────────────────────────────────────────
echo "📂 Copying config files to home directory..."

# Backup existing .zshrc if it exists and is not a symlink
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    echo "  📋 Backing up existing ~/.zshrc to ~/.zshrc.backup"
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi

cp "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
cp "$SCRIPT_DIR/p10k.zsh" "$HOME/.p10k.zsh"
cp "$SCRIPT_DIR/p10k-custom.zsh" "$HOME/.p10k-custom.zsh"

echo "  ✅ Config files installed:"
echo "     ~/.zshrc"
echo "     ~/.p10k.zsh"
echo "     ~/.p10k-custom.zsh"

# ─── Phase 5: Set ZSH as Default Shell (Codespaces/Linux) ───────────────────
if [ "$IS_CODESPACE" = true ] || [ "$IS_MACOS" = false ]; then
    ZSH_PATH="$(which zsh)"
    if [ -n "$ZSH_PATH" ]; then
        # Add zsh to /etc/shells if not already there
        if ! grep -q "$ZSH_PATH" /etc/shells 2>/dev/null; then
            echo "$ZSH_PATH" | sudo tee -a /etc/shells > /dev/null
        fi
        # Change default shell to zsh
        if [ "$SHELL" != "$ZSH_PATH" ]; then
            echo "🔄 Setting zsh as default shell..."
            sudo chsh -s "$ZSH_PATH" "$(whoami)" 2>/dev/null || true
        fi
    fi
fi

# ─── Phase 6: macOS Specific - VS Code Insiders ZDOTDIR ─────────────────────
if [ "$IS_MACOS" = true ]; then
    VSCODE_ZSH_DIR="$HOME/Library/Application Support/Code - Insiders/User/zsh"
    VSCODE_SETTINGS_DIR="$HOME/Library/Application Support/Code - Insiders/User"
    VSCODE_SETTINGS="$VSCODE_SETTINGS_DIR/settings.json"

    if [ -d "$VSCODE_SETTINGS_DIR" ]; then
        echo "⚙️  Configuring VS Code Insiders (macOS)..."
        mkdir -p "$VSCODE_ZSH_DIR"
        cp "$SCRIPT_DIR/.zshrc" "$VSCODE_ZSH_DIR/.zshrc"
        cp "$SCRIPT_DIR/p10k.zsh" "$VSCODE_ZSH_DIR/p10k.zsh"
        cp "$SCRIPT_DIR/p10k-custom.zsh" "$VSCODE_ZSH_DIR/p10k-custom.zsh"

        if [ -f "$VSCODE_SETTINGS" ]; then
            if ! grep -q "ZDOTDIR" "$VSCODE_SETTINGS" 2>/dev/null; then
                python3 -c "
import json
with open('$VSCODE_SETTINGS', 'r') as f:
    settings = json.load(f)
env_key = 'terminal.integrated.env.osx'
if env_key not in settings:
    settings[env_key] = {}
settings[env_key]['ZDOTDIR'] = '$VSCODE_ZSH_DIR'
with open('$VSCODE_SETTINGS', 'w') as f:
    json.dump(settings, f, indent=4)
"
                echo "  ✅ ZDOTDIR configured for VS Code Insiders"
            fi
        fi
    fi
fi

# ─── Done! ───────────────────────────────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════════════════════"
echo "✨ Installation complete!"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "📋 What was installed:"
echo "  • Oh My Zsh + Powerlevel10k theme"
echo "  • Plugins: zsh-autosuggestions, zsh-syntax-highlighting"
echo "  • Custom .zshrc, p10k.zsh, p10k-custom.zsh"
echo ""
if [ "$IS_CODESPACE" = true ]; then
    echo "☁️  Codespace: Reload terminal (kill + reopen) to see changes"
elif [ "$IS_MACOS" = true ]; then
    echo "🍎 macOS: Restart VS Code Insiders terminal"
else
    echo "🐧 Linux: Open a new terminal to see changes"
fi
echo ""
