dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

local comp_temp = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "fire_temp")
if comp_temp ~= nil then
    local temp = ComponentGetValue2(comp_temp, "value_int")

    if temp > 0 then
        EntityInflictDamage(root, 0.03 * (temp - 1), "DAMAGE_HOLY", "", "BLOOD_EXPLOSION", 2, 2, EntityGetWithTag("player_unit")[1], nil, nil, 20)

        local x, y = EntityGetTransform(this)

        local p = EntityGetInRadiusWithTag(x, y, 80, "player_unit") or {}
        if #p > 0 then
            AddHeat(1 + temp * 0.6, p[1])
        end

    end
    
else
   --GamePrint("FF - couldn't find temp component :(")
end