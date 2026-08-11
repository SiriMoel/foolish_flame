dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()

local root = EntityGetRootEntity(this)

if EntityHasTag(root, "player_unit") and (GetHeat(root) <= 150) then
    AddHeat(2, root)
end