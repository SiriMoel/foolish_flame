dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)
local x, y = EntityGetTransform(root)

local t = EntityGetInRadiusWithTag(x, y, 120, "player_unit") or {}

if #t > 0 then
    RemoveHeat(10, t[1])
end