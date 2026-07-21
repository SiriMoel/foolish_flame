dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local player = GetUpdatedEntityID()

if GetHeat(player) > 0 then
    RemoveHeat(3, player)
end