dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

local targets = EntityGetInRadiusWithTag(x, y, 320, "player_unit")

if #targets > 0 then
    local player = targets[1]
    local px, py = EntityGetTransform(player)
    local dist = math.sqrt((px - x)^2 + (py - y)^2)
    local amt = 2 + (320 - dist) * 0.025
    AddHeat(amt, player)
end