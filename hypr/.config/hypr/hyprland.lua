-- Hyprland Lua Configuration
-- Main config file that imports all modules
-- https://wiki.hypr.land/Configuring/Start/


-- ===================================================================
-- Configuration Modules
-- ===================================================================

-- Variables (must be loaded first as other modules depend on them)
local vars = require("config.variables")

-- Input configuration (keyboard layout, etc.)
require("config.input")

-- Monitor configuration
require("config.monitors")

-- Workspace rules
require("config.workspaces")

-- Appearance settings (themes, gaps, borders, etc.)
require("config.appearance")

-- Startup applications
require("config.startup")

-- Key and mouse bindings (must be loaded last as it depends on variables)
require("config.bindings")

-- ===================================================================
-- Notes:
-- - This is a modular configuration split into multiple files
-- - Each file in config/ handles a specific aspect of the configuration
-- - The order of loading matters:
--   1. variables.lua - Defines global variables used by other modules
--   2. input.lua - Keyboard and input settings
--   3. monitors.lua - Monitor configuration
--   4. workspaces.lua - Workspace rules
--   5. appearance.lua - Theme and appearance settings
--   6. startup.lua - Autostart applications
--   7. bindings.lua - Key and mouse bindings
-- ===================================================================
