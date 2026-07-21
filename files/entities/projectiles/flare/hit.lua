dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

local e = EntityGetAllChildren(root, "ff_magic_fire_effect") or {}

if #e > 0 then

    local x, y = EntityGetTransform(root)

    GamePlaySound("data/audio/Desktop/projectiles.bank", "player_projectiles/critical_hit/create", x, y)

    LoadGameEffectEntityTo(root, "mods/foolish_flame/files/entities/projectiles/flare/effect_hit.xml")

    local temp_dmg = 0

    local comp_temp = EntityGetFirstComponentIncludingDisabled(e[1], "VariableStorageComponent", "fire_temp")
    if comp_temp ~= nil then
        local temp = ComponentGetValue2(comp_temp, "value_int")
        temp_dmg = 0.04 * temp + 0.002 * GetHeat()

        AddHeat(6 + temp / 2)
    else
        GamePrint("FF - couldn't find temp component :(")
    end

    EntityInflictDamage(root, 0.4 + temp_dmg, "DAMAGE_HOLY", "", "BLOOD_EXPLOSION", 4, 4, EntityGetWithTag("player_unit")[1], nil, nil, 40)

    --[[local comp_vel = EntityGetFirstComponentIncludingDisabled(root, "VelocityComponent")
    if comp_vel ~= nil then
        local vel_x, vel_y = GameGetVelocityCompVelocity(root)

        vel_x = 0 -- placeholder // scorch shot behaviour?
        vel_y = -220 -- scale with fire temp

        ComponentSetValue2(comp_vel, "mVelocity", vel_x, vel_y)
    end]]
    
end

InflictMagicFire(root, 1, nil)

EntityKill(this)