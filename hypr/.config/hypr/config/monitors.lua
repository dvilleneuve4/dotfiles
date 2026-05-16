-- Monitor configuration
-- https://wiki.hypr.land/Configuring/Basics/Monitors/

-- HDMI-A-1 (right monitor)
hl.monitor({
    output = "HDMI-A-1",
    mode = "2560x1440",
    position = "2560x0",
    scale = 1.0,
})

-- DP-1 (left monitor)
hl.monitor({
    output = "DP-1",
    mode = "2560x1440",
    position = "0x0",
    scale = 1.0,
})
