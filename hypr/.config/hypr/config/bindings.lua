-- Key and mouse bindings
-- https://wiki.hypr.land/Configuring/Basics/Binds/

local vars = require("config.variables")

local mainMod = vars.mainMod
local terminal = vars.terminal
local fileManager = vars.fileManager
local menu = vars.menu

-- ===================================================================
-- Main Keybindings
-- ===================================================================

-- Terminal
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))

-- Kill active window
hl.bind(mainMod .. " + C", hl.dsp.window.close())

-- Shutdown/Exit
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))

-- File Manager
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

-- Toggle floating
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

-- Application menu (rofi)
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))

-- ===================================================================
-- Application Launchers
-- ===================================================================

-- WhatsApp (Brave browser)
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("brave --app=\"https://web.whatsapp.com\""))

-- YouTube (Brave browser)
hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.exec_cmd("brave --app=\"https://www.youtube.com\""))

-- ===================================================================
-- Screenshot Submap
-- ===================================================================

-- Define screenshot submap
-- local screenshotSubmap = hl.submap("screenshot")

-- Enter screenshot mode with mainMod + SHIFT + S
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.submap("screenshot"))

-- Bindings within the screenshot submap
-- Each binding automatically resets to the default submap after execution

hl.define_submap("screenshot", function()

    -- grimblast: copy area to clipboard
    hl.bind("S", hl.dsp.exec_cmd("grimblast --notify copy area"))

    -- grimblast: edit area in gimp
    hl.bind("E", hl.dsp.exec_cmd("grimblast --notify edit area"))

    -- grimblast: copy active window to clipboard
    hl.bind("A", hl.dsp.exec_cmd("grimblast --notify copy active"))
end )

-- ===================================================================
-- Workspace Management
-- ===================================================================

-- Switch to workspaces 1-10 with mainMod + [0-9]
-- Note: Key 0 maps to workspace 10
for i = 1, 10 do
    local key = i % 10  -- Maps 10 to 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
end

-- Move active window to workspaces 1-10 with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10  -- Maps 10 to 0
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- ===================================================================
-- Focus Movement
-- ===================================================================

-- Move focus with mainMod + arrow keys (vim-style: h=left, j=down, k=up, l=right)
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- ===================================================================
-- Lock Screen
-- ===================================================================

-- Lock screen with mainMod + SHIFT + L
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))

-- ===================================================================
-- Mouse Bindings
-- ===================================================================

-- Move window with mainMod + Left Mouse Button (272)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

-- Resize window with mainMod + Right Mouse Button (273)
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
