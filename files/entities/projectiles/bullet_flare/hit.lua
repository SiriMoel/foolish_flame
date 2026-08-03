dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

local heat_amt = 3

local e = EntityGetAllChildren(root, "ff_magic_fire_effect") or {}

if #e > 0 and not EntityHasTag(root, "player_unit") then

    local x, y = EntityGetTransform(root)

    GamePlaySound("data/audio/Desktop/projectiles.bank", "player_projectiles/critical_hit/create", x, y)

    local comp_temp = EntityGetFirstComponentIncludingDisabled(e[1], "VariableStorageComponent", "fire_temp")
    if comp_temp ~= nil then
        local temp = ComponentGetValue2(comp_temp, "value_int")

        heat_amt = heat_amt + 3 + temp * 0.4
    else
        --GamePrint("FF - couldn't find temp component :(")
    end    
end

AddHeat(heat_amt)

InflictMagicFire(root, 2, 600, 8)

EntityKill(this)