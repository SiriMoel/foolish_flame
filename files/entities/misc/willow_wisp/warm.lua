dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

local t = EntityGetInRadiusWithTag(x, y, 40, "player_unit")

if #t > 0 then
    AddHeat(2.65, t[1])
end