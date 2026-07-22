dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

local e = EntityGetAllChildren(root, "ff_magic_fire_effect") or {}

if #e > 0 and not EntityHasTag(root, "player_unit") then

    local x, y = EntityGetTransform(root)

    GamePlaySound("data/audio/Desktop/projectiles.bank", "player_projectiles/critical_hit/create", x, y)

    local temp_dmg = 0

    local comp_temp = EntityGetFirstComponentIncludingDisabled(e[1], "VariableStorageComponent", "fire_temp")
    if comp_temp ~= nil then
        local temp = ComponentGetValue2(comp_temp, "value_int")
        temp_dmg = 0.5 + 1.5 * temp + 0.005 * GetHeat()

        if temp >= 10 then
            temp_dmg = temp_dmg * 1.5
        end

        AddHeat(10 + temp * 2)

    else
        GamePrint("FF - couldn't find temp component :(")
    end

    local player = EntityGetWithTag("player_unit")[1]

    --[[local comp_dm = EntityGetFirstComponent(root, "DamageModelComponent")
    if comp_dm ~= nil then
        local hp = ComponentGetValue2(comp_dm, "hp")
        if hp - temp_dmg <= 0 then
            local effect = EntityLoad("mods/foolish_flame/files/entities/projectiles/axtinguisher/buff.xml", x, y)
		    EntityAddChild(player, effect)
            GamePlaySound("data/audio/Desktop/projectiles.bank", "player_projectiles/critical_hit/create", x, y)
            GamePrint("Pow!")
        end
    end]]
    local effect = EntityLoad("mods/foolish_flame/files/entities/projectiles/axtinguisher/buff.xml", x, y)
	EntityAddChild(player, effect)

    EntityInflictDamage(root, temp_dmg, "DAMAGE_HOLY", "", "BLOOD_EXPLOSION", 4, 4, player, nil, nil, 40)

    EntityKill(e[1])

else
    --InflictMagicFire(root, 3, 20)
end

EntityKill(this)