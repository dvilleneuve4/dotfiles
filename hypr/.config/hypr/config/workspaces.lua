-- Workspace configuration
-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Alternate workspaces between monitors
-- Odd workspaces (1, 3, 5, 7, 9) on HDMI-A-1 (right)
-- Even workspaces (2, 4, 6, 8, 10) on DP-1 (left)

-- Workspaces for HDMI-A-1 (right monitor)
hl.workspace_rule({
    workspace = 1,
    monitor = "HDMI-A-1",
})

hl.workspace_rule({
    workspace = 3,
    monitor = "HDMI-A-1",
})

hl.workspace_rule({
    workspace = 5,
    monitor = "HDMI-A-1",
})

hl.workspace_rule({
    workspace = 7,
    monitor = "HDMI-A-1",
})

hl.workspace_rule({
    workspace = 9,
    monitor = "HDMI-A-1",
})

-- Workspaces for DP-1 (left monitor)
hl.workspace_rule({
    workspace = 2,
    monitor = "DP-1",
})

hl.workspace_rule({
    workspace = 4,
    monitor = "DP-1",
})

hl.workspace_rule({
    workspace = 6,
    monitor = "DP-1",
})

hl.workspace_rule({
    workspace = 8,
    monitor = "DP-1",
})

hl.workspace_rule({
    workspace = 10,
    monitor = "DP-1",
})
