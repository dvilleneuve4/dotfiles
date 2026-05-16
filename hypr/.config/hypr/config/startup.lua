-- Autostart applications and services
-- https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Start applications on Hyprland launch
hl.on("hyprland.start", function()
    -- System services
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    
    -- Status bar
    hl.exec_cmd("waybar")
    
    -- Network manager applet
    hl.exec_cmd("nm-applet")
    
    -- Notification daemon
    hl.exec_cmd("swaync")
end)
