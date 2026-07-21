dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local player = GetUpdatedEntityID()

local heat = GetHeat(player)

if heat > 0 then
    local amt = 2

    if heat > 100 then
        amt = amt + 2
    end

    if heat > 150 then
        amt = amt + 2
    end
    
    if heat > 200 then
        amt = amt + 1 + math.ceil((heat - 200) / 5)
    end

    if heat > 300 then
        amt = amt * 1.4
    end

    RemoveHeat(amt, player)
end
