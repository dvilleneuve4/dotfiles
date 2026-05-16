-- Input configuration
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/

-- Keyboard layout configuration
-- US International layout for accents and special characters
-- kb_variant = "intl" enables dead keys (e.g., ' + e = é, ~ + n = ñ)
hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "intl",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        
        -- Mouse follows focus
        follow_mouse = 1,
        
        -- Mouse sensitivity (0 = no modification, -1.0 to 1.0)
        sensitivity = 0,
        
        -- Touchpad settings
        touchpad = {
            natural_scroll = false,
        },
    },
})
