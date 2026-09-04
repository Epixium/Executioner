Executioner = {}
ExecutionerCurrentMod = SMODS.current_mod

--#region Config

ExecutionerCurrentMod.config_tab = function()
    return {n = G.UIT.ROOT, config = {r = 0.1, align = "cm", padding = 0.1, colour = G.C.BLACK, minw = 8}, nodes = {
        {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
            {n = G.UIT.C, config = {align = "c", padding = 0}, nodes = {
                {n = G.UIT.T, config = {text = "Enable Jokers", colour = G.C.UI.TEXT_LIGHT, scale = 0.35}}
            }},
            {n = G.UIT.C, config = {align = "cl", padding = 0.05}, nodes = {
                create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = ExecutionerCurrentMod.config, ref_value = 'jokers_enabled' }
            }}
        }}
    }
}
end

--#endregion

--#region Atlases

SMODS.Atlas {
    key = 'jokers',
    path = 'jokers.png',
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = 'tarots',
    path = 'tarots.png',
    px = 71,
    py = 95
}

--#endregion

--#region File Loading

assert(SMODS.load_file("src/utils.lua"))()

local jokers_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/jokers")
for _, file in ipairs(jokers_src) do
    assert(SMODS.load_file("src/jokers/" .. file))()
end

local consumables_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/consumables")
for _, file in ipairs(consumables_src) do
    assert(SMODS.load_file("src/consumables/" .. file))()
end

--#endregion