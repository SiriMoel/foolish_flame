dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local card = GetUpdatedEntityID()

local root = EntityGetRootEntity(card)

if EntityHasTag(root, "player_unit") then

    local x, y = EntityGetTransform(root)

    local targets = EntityGetInRadiusWithTag(x, y, 110, "homing_target")

    if #targets > 0 then
        for i=1,#targets do
            local target = targets[i]

            if RemoveHeat2(0.22, root) then
                InflictMagicFire(target, 1, 240, 5)
            end
        end
    end
end