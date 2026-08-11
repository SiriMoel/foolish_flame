dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()

local root = EntityGetRootEntity(this)

if EntityHasTag(root, "player_unit") then
    local p_x, p_y = EntityGetTransform(root)

    local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent")
    if comp_controls ~= nil then
        local steps = 6
        local length = 32
        local radius = length / steps * 2

        local aim_x, aim_y = ComponentGetValue2(comp_controls, "mAimingVectorNormalized")
        local angle = math.atan2(aim_y, aim_x)

        local step_x = math.cos(angle) * radius
        local step_y = math.sin(angle) * radius

        for i=1,steps do
            local t_x, t_y = p_x + i * step_x, p_y - 4 + i * step_y
            local targets = EntityGetInRadiusWithTag(t_x, t_y, radius, "mortal") or {}
            if #targets > 0 then
                for ii=1,#targets do
                    local target = targets[ii]
                    if not EntityHasTag(target, "player_unit") then
                        local tr_x, tr_y = EntityGetTransform(target)
                        if not RaytraceSurfacesAndLiquiform(p_x, p_y - 4, tr_x, tr_y) then
                            local temp = GetFireTemperature(target)
                            InflictMagicFire(target, 3, 340, 10)
                            EntityInflictDamage(target, 0.04 + 0.04 * temp, "DAMAGE_HOLY", "", "NORMAL", 1, 1, root, nil, nil, 40)
                        end
                    end
                end
            end
            local targets2 = EntityGetInRadiusWithTag(t_x, t_y, radius, "projectile") or {}
            if #targets2 > 0 then
                for ii=1,#targets2 do
                    local target = targets2[ii]
                    local comp_proj = EntityGetFirstComponent(target, "ProjectileComponent")
                    if comp_proj ~= nil then
                        local shooter = ComponentGetValue2(comp_proj, "mWhoShot")
                        if root ~= shooter then
                            local damage = ComponentGetValue2(comp_proj, "damage")
                            AddHeat(7 + damage * 2, root)
                            EntityKill(target)
                        end
                    end
                end
            end
        end
    end
end