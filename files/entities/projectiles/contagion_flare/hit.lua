dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

if not EntityHasTag(root, "player_unit") then
    local e = EntityGetAllChildren(root, "ff_magic_fire_effect") or {}
    if #e > 0 then
        local x, y = EntityGetTransform(root)
        local comp_temp = EntityGetFirstComponentIncludingDisabled(e[1], "VariableStorageComponent", "fire_temp")
        if comp_temp ~= nil then
            local temp = ComponentGetValue2(comp_temp, "value_int")
            local holy_flames = EntityGetAllChildren(root, "ff_holy_flames") or {}
            local targets = EntityGetInRadiusWithTag(x, y, 56, "homing_target") or {}
            if #targets > 0 then
                local heated = false
                for i=1,#targets do
                    local target = targets[i]
                    if target ~= root and not EntityHasTag(target, "player_unit") then
                        InflictMagicFire(target, temp, 300, math.max(temp, 8))
                        local tx, ty = EntityGetTransform(target)
                        local dist_x, dist_y = x - tx, y - ty
                        local fx_x = x - 0.5 * dist_x
                        local fx_y = y - 0.5 * dist_y
                        EntityLoad("mods/foolish_flame/files/entities/projectiles/flare/particles_entity.xml", fx_x, fx_y)
                        if #holy_flames > 0 then
                            for i=1,#holy_flames do
                                local flame = EntityLoad("mods/foolish_flame/files/entities/projectiles/holy_flames/hit_entity.xml", tx, ty)
                                EntityAddChild(target, flame)
                            end
                        end
                        if not heated then
                            AddHeat(2 + temp * 0.4)
                            heated = true
                        end
                    end
                end
            end
        end
    end
    InflictMagicFire(root, 1, 300, 8)
end

EntityKill(this)