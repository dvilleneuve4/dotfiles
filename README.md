# dotfiles

My CachyOS Hyprland Configuration - Managed with GNU Stow

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

This repository contains my personal dotfiles for a complete Hyprland Wayland compositor setup, organized using GNU Stow. The configuration includes a modular Hyprland Lua config, Rofi application launcher, Waybar status bar, and theming for GTK applications.

## Inspiration & Credits

This configuration was inspired by and incorporates ideas from:

- **[Zilero232/arch-install-kit](https://github.com/Zilero232/arch-install-kit)** - Rofi configuration with Catppuccin/Kanagawa color themes
- **[typecraft-dev/dotfiles](https://github.com/typecraft-dev/dotfiles)** - Overall structure and organization ideas

## Prerequisites

### Required Packages

**Window Management & Compositor:**
- `hyprland` - Wayland compositor
- `hyprlock` - Screen locker
- `hypridle` - Idle management
- `xdg-desktop-portal-hyprland` - Screen sharing support

**Status Bar & Launchers:**
- `waybar` - Status bar
- `rofi` - Application launcher (with `rofi-wayland`)
- `swaync` - Notification daemon

**Utilities:**
- `nm-applet` - Network manager applet
- `grimblast` - Screenshot tool
- `kitty` - Terminal emulator
- `nautilus` - File manager
- `brave` - Web browser
- `pavucontrol` - Audio control
- `mpd` / `mpc` - Music player daemon (optional, for waybar module)

**Theming:**
- `qt6ct` - Qt6 theme configuration
- `adw-gtk3` - GTK3 theme for dark mode
- `papirus-icon-theme` - Icon theme (used in rofi)
- `jetbrains-mono-nerd-fonts` - Font for rofi and waybar
- `ttf-nerd-fonts-symbols` - Nerd Font symbols

**Wallpaper Management:**
- `awwww` - Wallpaper manager (TODO)

**Shell & Prompt:**
- `starship` - Shell prompt (TODO)

### Fonts

Required Nerd Fonts for icons:
```bash
sudo pacman -S jetbrains-mono-nerd-fonts ttf-nerd-fonts-symbols
```

## Installation

### 1. Clone the Repository

```bash
cd ~
git clone https://github.com/dvilleneuve4/dotfiles.git
git clone git@github.com:dvilleneuve4/dotfiles.git  # If using SSH
```

### 2. Install GNU Stow

```bash
# Arch Linux
sudo pacman -S stow

# Debian/Ubuntu
sudo apt install stow
```

### 3. Deploy All Configurations

```bash
cd ~/dotfiles

# Deploy all packages
for pkg in hypr rofi waybar gtk brave-apps; do
    stow -v -S $pkg -t ~
done
```

**Note:** The `brave-apps` package contains custom `.desktop` files for Brave browser applications (WhatsApp, YouTube). These will be symlinked to `~/.local/share/applications/`.

### 4. Install Required Packages

On **Arch Linux** (CachyOS):

```bash
# Core window management
sudo pacman -S hyprland hyprlock hypridle xdg-desktop-portal-hyprland

# Status bar and launchers
sudo pacman -S waybar rofi-wayland swaync

# Utilities
sudo pacman -S networkmanager-applet grimblast kitty nautilus pavucontrol mpd mpc

# Theming
sudo pacman -S qt6ct adw-gtk3 papirus-icon-theme jetbrains-mono-nerd-fonts ttf-nerd-fonts-symbols

# GTK theme settings
sudo pacman -S gsettings-desktop-schemas
```

### 5. Enable Services

```bash
# Enable Hyprland polkit agent (for system dialogues)
systemctl --user enable --now hyprpolkitagent

# Enable swaync notification daemon
systemctl --user enable --now swaync
```

## Directory Structure

Each package mirrors its target location in the home directory:

```
dotfiles/
├── hypr/                          # ~/.config/hypr/
│   └── .config/
│       └── hypr/
│           ├── hyprland.lua        # Main Lua config (entry point)
│           ├── hyprlock.conf       # Screen locker config
│           └── config/
│               ├── variables.lua   # Global variables
│               ├── startup.lua     # Autostart applications
│               ├── monitors.lua    # Monitor configuration
│               ├── workspaces.lua  # Workspace rules
│               ├── input.lua       # Keyboard layout (US International)
│               ├── bindings.lua    # Key and mouse bindings
│               └── appearance.lua  # Theme and appearance
│
├── rofi/                         # ~/.config/rofi/
│   └── .config/
│       └── rofi/
│           ├── config.rasi        # Rofi configuration
│           └── colors.rasi         # Kanagawa color theme
│
├── waybar/                       # ~/.config/waybar/
│   └── .config/
│       └── waybar/
│           ├── config.jsonc       # Waybar modules
│           ├── style.css          # Base styling
│           ├── power_menu.xml      # Power menu
│           └── themes/
│               └── kanagawa.css    # Kanagawa color theme
│
├── gtk/                          # ~/.config/gtk-*/
│   └── .config/
│       └── gtk-*/
│           └── settings.ini       # GTK dark mode
│
├── brave-apps/                   # ~/.local/share/applications/
│   └── .local/
│       └── share/
│           └── applications/
│               ├── brave-whatsapp.desktop
│               └── brave-youtube.desktop
│
├── LICENSE
└── README.md
```

## Configuration Details

### Hyprland

The Hyprland configuration uses the new **Lua format** (0.55.0+) with a modular structure:

- **Variables** (`config/variables.lua`): Defines global variables like `mainMod`, `terminal`, etc.
- **Startup** (`config/startup.lua`): Applications launched on Hyprland start
- **Monitors** (`config/monitors.lua`): Dual monitor setup (HDMI-A-1 right, DP-1 left)
- **Workspaces** (`config/workspaces.lua`): 10 workspaces alternating between monitors
- **Input** (`config/input.lua`): **US International keyboard layout** for accents/special characters
- **Bindings** (`config/bindings.lua`): All keybindings including screenshot submap
- **Appearance** (`config/appearance.lua`): Dark theme, gaps, borders, shadows, blur

#### Keyboard Layout (US International)

The configuration enables **US International layout** (`kb_variant = "intl"`), which provides dead keys for typing accents and special characters:

| Dead Key + Letter | Result |
|-------------------|--------|
| `'` + `e` | é |
| `'` + `a` | á |
| `'` + `u` | ú |
| `` ` `` + `e` | è |
| `` ` `` + `a` | à |
| `~` + `n` | ñ |
| `^` + `u` | û |
| `"` + `u` | ü |

### Rofi

- **Theme**: Kanagawa color scheme with transparency
- **Font**: JetBrains Mono Nerd Font
- **Modes**: drun (desktop entries), run (commands), window (window switcher)
- **Sidebar**: Mode switching on the side

### Waybar

- **Position**: Top bar
- **Modules**: Workspaces, window title, MPD, idle inhibitor, volume, CPU, memory, temperature, keyboard, language, clock, notifications, tray, power menu
- **Theme**: Kanagawa color scheme

## GNU Stow Commands

### Deploy a Package
```bash
stow -v -S <package> -t ~
```

### Undo (Remove Symlinks)
```bash
stow -v -D <package> -t ~
```

### Re-stow (Update Existing)
```bash
stow -v -R <package> -t ~
```

### List Deployed Packages
```bash
stow -v -l -t ~
```

### Override Conflicts
```bash
stow -v -S --override=* <package> -t ~
```

## Usage

### Hyprland Keybindings

| Key | Action |
|-----|--------|
| `SUPER + Q` | Open terminal (kitty) |
| `SUPER + E` | Open file manager (nautilus) |
| `SUPER + R` | Open application launcher (rofi) |
| `SUPER + C` | Close active window |
| `SUPER + M` | Shutdown / Exit |
| `SUPER + V` | Toggle floating |
| `SUPER + 1-0` | Switch to workspace 1-10 |
| `SUPER + SHIFT + 1-0` | Move window to workspace 1-10 |
| `SUPER + h/j/k/l` | Move focus (vim-style) |
| `SUPER + SHIFT + S` | Screenshot mode |
| `SUPER + SHIFT + L` | Lock screen |
| `SUPER + SHIFT + W` | Open WhatsApp (Brave) |
| `SUPER + SHIFT + Y` | Open YouTube (Brave) |

#### Screenshot Mode
After pressing `SUPER + SHIFT + S`:
- `S` - Copy area to clipboard
- `E` - Edit area in GIMP
- `A` - Copy active window to clipboard
- `ESC` - Cancel

### Wallpaper Management (TODO)

Planned setup with `awwww`:
- Store wallpaper **links only** in repository (not actual image files)
- Script to download/update wallpapers from links
- `.gitignore` will exclude actual image files

## TO-DO

- [ ] **Binding Cheatsheet**: Create a reference document or script that displays all current keybindings
- [ ] **Hypridle Setup**:
  - Configure `hypridle` to lock the screen after idle timeout
  - Add Waybar widget/module to pause/unpause `hypridle` (e.g., during presentations or video playback)
- [ ] **Wallpaper Management**:
  - Install and configure `awwww` for wallpaper management
  - Store only wallpaper **URLs/links** in the repository (not binary files)
  - Create a script to fetch/update wallpapers from links
  - Ensure image files are in `.gitignore`
  - Add `.gitattributes` if needed for line ending consistency
- [ ] **Terminal Styling**:
  - Configure Kitty terminal theme
  - Install and configure `starship` prompt

## Troubleshooting

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

## Resources

- **[Hyprland Wiki](https://wiki.hypr.land/)** - Official documentation
- **[GNU Stow Manual](https://www.gnu.org/software/stow/manual/)** - Symlink farm manager
- **[Arch Wiki: Dotfiles](https://wiki.archlinux.org/title/Dotfiles)** - Dotfile management
- **[Zilero232/arch-install-kit](https://github.com/Zilero232/arch-install-kit)** - Rofi theme inspiration
- **[typecraft-dev/dotfiles](https://github.com/typecraft-dev/dotfiles)** - Structure inspiration

---

**Maintainer**: [dvilleneuve4](https://github.com/dvilleneuve4)

**Repository**: [github.com/dvilleneuve4/dotfiles](https://github.com/dvilleneuve4/dotfiles)

**License**: [MIT](LICENSE)
