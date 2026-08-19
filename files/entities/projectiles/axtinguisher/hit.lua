dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

local e = EntityGetAllChildren(root, "ff_magic_fire_effect") or {}

if #e > 0 and not EntityHasTag(root, "player_unit") then

    local x, y = EntityGetTransform(root)

    local player = EntityGetWithTag("player_unit")[1]

    GamePlaySound("data/audio/Desktop/projectiles.bank", "player_projectiles/critical_hit/create", x, y)

    local temp_dmg = 0

    local comp_temp = EntityGetFirstComponentIncludingDisabled(e[1], "VariableStorageComponent", "fire_temp")
    if comp_temp ~= nil then
        local temp = ComponentGetValue2(comp_temp, "value_int")
        temp_dmg = 0.24 + 0.2 * temp + 0.004 * GetHeat(player)

        if temp >= 10 then
            temp_dmg = temp_dmg * 1.4
        end

        AddHeat(8 + temp * 2, player)
    end


    EntityInflictDamage(root, temp_dmg, "DAMAGE_HOLY", "", "BLOOD_EXPLOSION", 4, 4, player, nil, nil, 40)

    EntityKill(e[1])

else
    --InflictMagicFire(root, 3, 20)
end

EntityKill(this)