# dotfiles

My CachyOS Hyprland Configuration - Managed with GNU Stow

This repository contains all my dotfiles, organized using GNU Stow with proper package structure.

## 📁 Directory Structure

Each package mirrors its target location in the home directory:

```
dotfiles/
├── hypr/                      # Package: ~/.config/hypr/*
│   └── .config/
│       └── hypr/
│           ├── hyprland.conf  # Legacy config
│           └── hyprland.lua   # New Lua config
│
├── rofi/                     # Package: ~/.config/rofi/*
│   └── .config/
│       └── rofi/
│           ├── config.rasi
│           └── colors.rasi
│
├── waybar/                   # Package: ~/.config/waybar/*
│   └── .config/
│       └── waybar/
│           ├── config
│           └── style.css
│
├── kitty/                    # Package: ~/.config/kitty/*
│   └── .config/
│       └── kitty/
│
├── fish/                     # Package: ~/.config/fish/*
│   └── .config/
│       └── fish/
│
├── swaync/                   # Package: ~/.config/swaync/*
│   └── .config/
│       └── swaync/
│
├── micro/                    # Package: ~/.config/micro/*
│   └── .config/
│       └── micro/
│
├── applications/              # Package: ~/.local/share/applications/*
│   └── .local/
│       └── share/
│           └── applications/
│               ├── Cyberpunk 2077.desktop
│               ├── brave-agimnkijcaahngcdmfeangaknmldooml-Default.desktop
│               └── foundry-vtt.desktop
│
├── icons/                    # Package: ~/.local/share/icons/*
│   └── .local/
│       └── share/
│           └── icons/
│               └── hicolor/
│                   ├── 16x16/apps/
│                   ├── 32x32/apps/
│                   └── ...
│
├── dotfiles/                 # Package: ~/.* (dotfiles)
│   └── home/
│       ├── .zshrc
│       ├── .gitconfig
│       ├── .bash_profile
│       ├── .bashrc
│       └── .vibe/
│
├── misc/                     # Package: other ~/.config/* files
│   └── .config/
│       ├── baloofileinformationrc
│       ├── dolphinrc
│       └── ...
│
├── .gitignore
├── LICENSE
├── README.md
└── setup.sh
```

## 🚀 Quick Start

### Prerequisites

- **GNU Stow**: `sudo pacman -S stow` (Arch) or `sudo apt install stow` (Debian/Ubuntu)
- **Git**: `sudo pacman -S git` or `sudo apt install git`

### Initial Setup

```bash
cd ~/dotfiles
chmod +x setup.sh
./setup.sh
```

Answer `y` to all prompts. The script will:
1. Create package directories with mirrored structure
2. Copy configs to package directories (originals preserved)
3. Create symlinks using GNU Stow
4. Initialize Git and create a version tag
5. Verify all symlinks

### Restoration on Fresh System

```bash
# Clone repository
git clone git@github.com:dvilleneuve4/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Stow all packages
stow -v -S hypr -t ~
stow -v -S rofi -t ~
stow -v -S waybar -t ~
stow -v -S kitty -t ~
stow -v -S fish -t ~
stow -v -S swaync -t ~
stow -v -S micro -t ~
stow -v -S applications -t ~
stow -v -S icons -t ~
stow -v -S dotfiles -t ~
stow -v -S misc -t ~
```

Or use a loop:
```bash
for pkg in hypr rofi waybar kitty fish swaync micro applications icons dotfiles misc; do
    stow -v -S $pkg -t ~
done
```

## 🔄 GNU Stow Commands

### Deploy
```bash
stow -v -S <package> -t ~
```

### Undo
```bash
stow -v -D <package> -t ~
```

### Re-stow (Update)
```bash
stow -v -R <package> -t ~
```

### List
```bash
stow -v -l -t ~
```

### Override Conflicts
```bash
stow -v -S --override=* <package> -t ~
```

## 📝 Git Workflow

```bash
cd ~/dotfiles

# After changes
git add .
git commit -m "Updated Hyprland config"
git tag -a "update-$(date +%Y%m%d-%H%M%S)" -m "Config updates"
git push
git push --tags
```

### Rollback

```bash
# List tags
git tag -l

# Checkout old version
git checkout tags/old-version

# Re-stow all packages
for pkg in hypr rofi waybar kitty fish swaync micro applications icons dotfiles misc; do
    stow -v -R $pkg -t ~
done

# Return to main
git checkout main
```

## ✅ Verification

```bash
# Check key symlinks
ls -la ~/.config/hypr/hyprland.conf
ls -la ~/.local/share/applications/
ls -la ~/.zshrc

# All should show -> /home/dvillene/dotfiles/<package>/...
```

## 🛠️ Troubleshooting

### "Target already exists"
```bash
# Remove the conflicting file/directory first
rm -rf ~/.config/hypr
stow -v -S hypr -t ~
```

### "No ownership info"
This is a warning, not an error. Suppress with:
```bash
stow -v --no-conflict -S <package> -t ~
```

### Broken Symlinks
```bash
# Find broken symlinks
find ~ -xtype l

# Remove and re-stow
rm ~/.config/hypr
stow -v -S hypr -t ~
```

### Files Not Appearing
```bash
# Check source exists
ls -la ~/dotfiles/hypr/.config/hypr/

# Re-stow with verbose
stow -v -v -S hypr -t ~
```

## 📖 Understanding the Structure

GNU Stow works by creating symlinks from a package directory to a target. The package directory must mirror the target structure.

**Example:**
```
Source: ~/dotfiles/hypr/.config/hypr/hyprland.conf
         ↓ (stow -S hypr -t ~)
Target: ~/.config/hypr/hyprland.conf ← symlink to source
```

Each package is self-contained and can be stowed independently.

## 📚 Resources

- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/)
- [Arch Wiki: Dotfiles](https://wiki.archlinux.org/title/Dotfiles)

---

**Maintainer**: dvillene (David Villeneuve)
**Repository**: [github.com/dvilleneuve4/dotfiles](https://github.com/dvilleneuve4/dotfiles)
**License**: [MIT](LICENSE)
