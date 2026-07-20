local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

local e = EntityGetAllChildren(root, "ff_magic_fire_effect") or {}

if #e > 0 then
    --GamePrint("hit entity with magic fire")

    local x, y = EntityGetTransform(root)

    LoadGameEffectEntityTo(root, "mods/foolish_flame/files/entities/projectiles/flare/effect_hit.xml")

    EntityInflictDamage(root, 0.46, "DAMAGE_HOLY", "", "BLOOD_EXPLOSION", 4, 4, EntityGetWithTag("player_unit")[1], nil, nil, 40)

    GamePlaySound("data/audio/Desktop/projectiles.bank", "player_projectiles/critical_hit/create", x, y)

    --[[local comp_vel = EntityGetFirstComponentIncludingDisabled(root, "VelocityComponent")
    if comp_vel ~= nil then
        local vel_x, vel_y = GameGetVelocityCompVelocity(root)

        vel_x = 0 -- placeholder // scorch shot behaviour?
        vel_y = -220 -- scale with fire temp

        ComponentSetValue2(comp_vel, "mVelocity", vel_x, vel_y)
    end]]
    
end

EntityKill(this)