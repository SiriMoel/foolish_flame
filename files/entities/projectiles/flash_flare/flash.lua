dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

local e = EntityGetAllChildren(root, "ff_magic_fire_effect") or {}

if #e > 0 and not EntityHasTag(root, "player_unit") then
    local x, y = EntityGetTransform(root)
    local comp_temp = EntityGetFirstComponentIncludingDisabled(e[1], "VariableStorageComponent", "fire_temp")
    if comp_temp ~= nil then
        local temp = ComponentGetValue2(comp_temp, "value_int")

        local comp_amt = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "ff_flash_amt")        
        if comp_amt ~= nil then
            local amt = ComponentGetValue2(comp_amt, "value_float") or 0
            amt = amt * (1 + temp * 0.05)
            EntityInflictDamage(root, amt, "DAMAGE_HOLY", "", "BLOOD_EXPLOSION", 1, 1, EntityGetWithTag("player_unit")[1], nil, nil, 0)
            GamePlaySound("data/audio/Desktop/projectiles.bank", "player_projectiles/bullet_laser/bounce", x, y)
            EntityLoad("mods/foolish_flame/files/entities/projectiles/flash_flare/particles_entity.xml", x, y)
        end
    end    
end

EntityKill(this)