# 🚀 Ahtasham's Advanced ZSH Dotfiles

> **MacBook jaisi terminal — har jagah!**
> Ye dotfiles aapke GitHub Codespaces ko automatically aapke MacBook jaisa bana deti hain.

---

## 📁 Files

| File | Description |
|------|-------------|
| `install.sh` | Master installer — Codespaces, macOS, Linux sab ke liye kaam karta hai |
| `.zshrc` | Zsh configuration (Oh My Zsh + Powerlevel10k + plugins) |
| `p10k.zsh` | Powerlevel10k theme configuration (rainbow style) |
| `p10k-custom.zsh` | Custom overrides (name, time format, git colors) |

---

## ☁️ GitHub Codespaces Setup (Auto-Install)

### Step 1: GitHub pe Repository Banao

```bash
cd ~/Developer/zsh
git init
git add .
git commit -m "feat: add advanced zsh dotfiles"
```

### Step 2: GitHub pe Push Karo

GitHub pe ek naya repository banao (naam: `dotfiles` ya kuch bhi) aur push karo:

```bash
git remote add origin https://github.com/YOUR_USERNAME/dotfiles.git
git branch -M main
git push -u origin main
```

### Step 3: GitHub Settings Mein Enable Karo

1. **[github.com/settings/codespaces](https://github.com/settings/codespaces)** pe jao
2. **"Dotfiles"** section dhundho
3. **"Automatically install dotfiles"** toggle ON karo ✅
4. **Repository** dropdown se apna `dotfiles` repo select karo
5. **Save** karo

> ⚡ GitHub Codespaces sirf `install.sh` (ya `install`, `bootstrap.sh`, `setup.sh`, `script/setup`) naam ki file dhundta hai aur khud-ba-khud run karta hai.

### Step 4: Test Karo

Koi bhi naya Codespace kholein — terminal automatically Powerlevel10k wala prompt dikhayega! 🎉

---

## 🍎 macOS Setup (VS Code Insiders)

macOS pe sirf yehi command chalao:

```bash
cd ~/Developer/zsh
chmod +x install.sh
./install.sh
```

Ye script macOS detect karke VS Code Insiders ke liye ZDOTDIR configure kar degi.

---

## 🔄 Changes Update Karna

Jab bhi config change karo:

```bash
cd ~/Developer/zsh
git add .
git commit -m "update: zsh config"
git push
```

Agla naya Codespace automatically updated config use karega.

---

## 🎨 Included Features

- **Oh My Zsh** — Framework
- **Powerlevel10k** — Rainbow theme with slanted separators
- **zsh-autosuggestions** — Command suggestions as you type
- **zsh-syntax-highlighting** — Syntax colors in terminal
- **Custom "Ahtasham" name** in prompt
- **12-hour time format** (AM/PM)
- **Transient prompt** — Clean previous commands
- **Git status** — Branch, ahead/behind, staged/unstaged/untracked

---

## ⚠️ Note

- Codespace mein Nerd Font automatically kaam karta hai (VS Code built-in support)
- macOS pe [MesloLGS NF](https://github.com/romkatv/powerlevel10k#manual-font-installation) font install karein
