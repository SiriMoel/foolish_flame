dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

local heat_amt = 2

local e = EntityGetAllChildren(root, "ff_magic_fire_effect") or {}

if #e > 0 and not EntityHasTag(root, "player_unit") then

    local x, y = EntityGetTransform(root)

    GamePlaySound("data/audio/Desktop/projectiles.bank", "player_projectiles/critical_hit/create", x, y)

    local temp_dmg = 0

    local comp_temp = EntityGetFirstComponentIncludingDisabled(e[1], "VariableStorageComponent", "fire_temp")
    if comp_temp ~= nil then
        local temp = ComponentGetValue2(comp_temp, "value_int")
        temp_dmg = 0.04 * temp + 0.002 * GetHeat()

        heat_amt = heat_amt + 3 + temp * 0.5
    else
        --GamePrint("FF - couldn't find temp component :(")
    end

    EntityInflictDamage(root, 0.4 + temp_dmg, "DAMAGE_HOLY", "", "BLOOD_EXPLOSION", 1, 1, EntityGetWithTag("player_unit")[1], nil, nil, 40)
end

AddHeat(heat_amt)

InflictMagicFire(root, 1, nil)

EntityKill(this)