dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local p = EntityGetInRadiusWithTag(x, y, 5, "player_unit") or {}
if #p > 0 then
    local comp = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "heat_amt")
    if comp ~= nil then
        local amt = ComponentGetValue2(comp, "value_float")
        AddHeat(amt, p[1])
        EntityKill(this)
    end
end