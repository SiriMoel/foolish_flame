dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local card = GetUpdatedEntityID()

local root = EntityGetRootEntity(card)

if EntityHasTag(root, "player_unit") then

    local x, y = EntityGetTransform(root)

    local targets = EntityGetInRadiusWithTag(x, y, 20, "homing_target")

    if #targets > 0 then
        for i=1,#targets do
            InflictMagicFire(target[i], 1, nil, 2) -- for free!
        end
    end
end