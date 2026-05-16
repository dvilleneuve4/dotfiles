-- Appearance and theme configuration
-- https://wiki.hypr.land/Configuring/Basics/Variables/

-- General appearance settings
hl.config({
    general = {
        -- Window gaps
        gaps_in = 5,
        gaps_out = 20,
        
        -- Window borders
        border_size = 2,
        
        -- Layout
        layout = "dwindle",
    },
    
    decoration = {
        -- Window rounding
        rounding = 10,
        rounding_power = 2,
        
        -- Window opacity
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        
        -- Shadows
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a,
        },
        
        -- Blur
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    
    animations = {
        enabled = true,
    },
    
    -- Layout-specific settings
    dwindle = {
        preserve_split = true,
    },
    
    master = {
        new_status = "master",
    },
    
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

-- Environment variables for theme consistency
-- Force dark mode for GTK4 apps (libadwaita)
hl.env("GSETTINGS_SCHEMA_DIR", "/usr/share/glib-2.0/schemas")

-- Force dark mode for GTK3 apps
hl.env("GTK_THEME", "adw-gtk3")

-- Qt application theme
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- Cursor settings
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Set dark color scheme for GTK apps
hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")
hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3")
