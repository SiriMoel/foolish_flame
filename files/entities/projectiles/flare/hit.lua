-- wouldn't it be so cool if we had an on-hit callback?
-- wouldn't it be so cool if we had an on-hit callback?
-- wouldn't it be so cool if we had an on-hit callback?
-- wouldn't it be so cool if we had an on-hit callback?
-- wouldn't it be so cool if we had an on-hit callback?
-- wouldn't it be so cool if we had an on-hit callback?
-- wouldn't it be so cool if we had an on-hit callback?
-- wouldn't it be so cool if we had an on-hit callback?
-- wouldn't it be so cool if we had an on-hit callback?
-- wouldn't it be so cool if we had an on-hit callback?

dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

local heat_amt = 2

local e = EntityGetAllChildren(root, "ff_magic_fire_effect") or {}

if #e > 0 and not EntityHasTag(root, "player_unit") then

    local x, y = EntityGetTransform(root)

    GamePlaySound("data/audio/Desktop/projectiles.bank", "player_projectiles/critical_hit/create", x, y)
    EntityLoad("mods/foolish_flame/files/entities/projectiles/flare/particles_entity.xml", x, y)

    local damage = 0.2

    local comp_temp = EntityGetFirstComponentIncludingDisabled(e[1], "VariableStorageComponent", "fire_temp")
    if comp_temp ~= nil then
        local temp = ComponentGetValue2(comp_temp, "value_int")
        damage = 0.02 * temp + 0.004 * GetHeat()

        heat_amt = heat_amt + 1 + temp * 0.5
    end

    EntityInflictDamage(root, damage, "DAMAGE_HOLY", "", "BLOOD_EXPLOSION", 1, 1, EntityGetWithTag("player_unit")[1], nil, nil, 0)
end

AddHeat(heat_amt)

InflictMagicFire(root, 1, nil, 5)

EntityKill(this)