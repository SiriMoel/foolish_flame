dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()

local root = EntityGetRootEntity(this)

if EntityHasTag(root, "player_unit") and (GetHeat(root) <= 50) then
    local amt = tonumber(GlobalsGetValue("ff_brimstone_heat", "4")) or 4
    AddHeat(amt/4, root)
end