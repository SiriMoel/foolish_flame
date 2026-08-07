dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

if EntityHasTag(root, "player_unit") then
    RemoveHeat(GetHeat(root) * 0.5, root)
end

EntityKill(this)