dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

local heat_amt = 2

local e = EntityGetAllChildren(root, "ff_magic_fire_effect") or {}

if #e > 0 and not EntityHasTag(root, "player_unit") then
    local x, y = EntityGetTransform(root)
    local comp_temp = EntityGetFirstComponentIncludingDisabled(e[1], "VariableStorageComponent", "fire_temp")
    if comp_temp ~= nil then
        local temp = ComponentGetValue2(comp_temp, "value_int")
        heat_amt = heat_amt + temp * 0.6
    end    
end

AddHeat(heat_amt)

InflictMagicFire(root, 2, 360, 8)

EntityKill(this)