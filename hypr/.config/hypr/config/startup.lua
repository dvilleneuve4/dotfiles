-- Autostart applications and services
-- https://wiki.hypr.land/Configuring/Basics/Autostart/

local vars = require("config.variables")

-- Start applications on Hyprland launch
hl.on("hyprland.start", function()
    -- System services
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    
    -- Idle management daemon
    hl.exec_cmd("hypridle")
    
    -- Status bar
    hl.exec_cmd("waybar")
    
    -- Network manager applet
    hl.exec_cmd("nm-applet")
    
    -- Notification daemon
    hl.exec_cmd("swaync")
    
    -- Start awww daemon for wallpaper management
    hl.exec_cmd("awww-daemon --layer background")
    
    -- Set initial wallpaper after daemon starts (wait 1 second for daemon to be ready)
    hl.exec_cmd("sleep 1 && awww img --transition-type simple --transition-step 2 --resize crop --filter Lanczos3 --all \"$(ls " .. vars.wallpaperDir .. " 2>/dev/null | shuf -n 1 || echo '')\"")
    
    -- Start wallpaper rotation script (changes every 5 minutes per display)
    hl.exec_cmd(vars.wallpaperDir .. "/../rotate_wallpapers.sh " .. vars.wallpaperDir .. " 300")
end)
