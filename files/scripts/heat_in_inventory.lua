dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()

local root = EntityGetRootEntity(this)

if EntityHasTag(root, "player_unit") then
    local amt = tonumber(GlobalsGetValue("ff_brimstone_heat", "4")) or 4
    if amt > 0 then
        local cap = amt * 10 + 10
        if GetHeat(root) <= cap then
            AddHeat(amt/4, root)
        end
    end
end