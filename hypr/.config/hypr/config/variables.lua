-- Global variables for Hyprland configuration
-- These can be accessed by other config files

local M = {}

-- Main modifier key
M.mainMod = "SUPER"

-- Applications
M.terminal = "kitty"
M.fileManager = "nautilus"
M.menu = "rofi -show drun"

-- Wallpaper directory for awww
M.wallpaperDir = os.getenv("HOME") .. "/.local/share/awww/wallpapers"

return M
