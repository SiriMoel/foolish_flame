dofile_once("data/scripts/lib/utilities.lua")

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
        return true
    end
end
    return false
end

function GetHeat(player)
    player = player or EntityGetWithTag("player_unit")[1]
    if player == nil then return 0 end
    local comp = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "ff_heat")
    if comp == nil then return 0 end
    return ComponentGetValue2(comp, "value_float")
end

function AddHeat(amt, player)
    player = player or EntityGetWithTag("player_unit")[1]
    if player == nil then return end
    local comp = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "ff_heat")
    if comp == nil then return end
    ComponentSetValue2(comp, "value_float", ComponentGetValue2(comp, "value_float") + amt)
end

function RemoveHeat(amt, player)
    player = player or EntityGetWithTag("player_unit")[1]
    if player == nil then return end
    local comp = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "ff_heat")
    if comp == nil then return end
    ComponentSetValue2(comp, "value_float", math.max(ComponentGetValue2(comp, "value_float") - amt, 0))
end

function RemoveHeat2(amt, player) -- you have alerted the cat
    player = player or EntityGetWithTag("player_unit")[1]
    if player == nil then return false, 0 end
    local comp = EntityGetFirstComponentIncludingDisabled(player, "VariableStorageComponent", "ff_heat")
    if comp == nil then return false, 0 end
    local heat = ComponentGetValue2(comp, "value_float") - amt
    ComponentSetValue2(comp, "value_float", math.max(heat, 0))
    if heat >= 0 then
        return true, heat + amt
    else
        return false, 0
    end
end

function InflictMagicFire(target, temp, duration, tmax)
    temp = temp or 1
    duration = duration or 360
    tmax = tmax or 5

    if not EntityGetIsAlive(target) or EntityHasTag(target, "player_unit") then return end

    local x, y = EntityGetTransform(target)

    local is_bounty = EntityHasTag(target, "ff_bounty_enemy")

    local nearby_bounty_enemies = EntityGetInRadiusWithTag(x, y, 160, "ff_bounty_enemy") or {}
    if (not is_bounty) and (#nearby_bounty_enemies > 0) then
        return
    end

    local effect

    local c = EntityGetAllChildren(target, "ff_magic_fire_effect") or {}
    if #c > 0 then
        effect = c[1]
    else
        effect = EntityLoad("mods/foolish_flame/files/entities/misc/effect_magic_fire/effect.xml", x, y)
        EntityAddChild(target, effect)
    end
    
    if effect == nil then return end -- this shouldn't happen?

    local player = EntityGetWithTag("player_unit")[1]
    if player == nil then return end -- probably shouldn't happen?

    if is_bounty then
        local comp_last_heated = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "ff_bounty_frame_heated_last")
        if comp_last_heated ~= nil then
            local frame_heated_last = ComponentGetValue2(comp_last_heated, "value_int")
            local frame_now = GameGetFrameNum()
            if not (frame_now >= frame_heated_last + 90) then
                temp = 0
            else
                temp = math.min(temp, 1)
                ComponentSetValue2(comp_last_heated, "value_int", frame_now)
            end
        end
    end

    local comp_eff = EntityGetFirstComponent(effect, "GameEffectComponent")
    if comp_eff ~= nil then
        local frames = ComponentGetValue2(comp_eff, "frames")

        local duration_mods = EntityGetAllChildren(target, "ff_fire_duration") or {}
        if duration ~= -1 then
            duration = duration + 120 * #duration_mods
        end

        ComponentSetValue2(comp_eff, "frames", ((duration == -1 --[[or frames == -1]]) and -1) or math.max(frames, duration))
    end

    local comp_temp = EntityGetFirstComponentIncludingDisabled(effect, "VariableStorageComponent", "fire_temp")
    if comp_temp ~= nil then
        local temp_before = ComponentGetValue2(comp_temp, "value_int")

        local temp_now = temp_before

        local hotter_fire_mods = EntityGetAllChildren(target, "ff_hotter_flares") or {}
        temp = temp + #hotter_fire_mods
        tmax = math.min(tmax + #hotter_fire_mods, 10)

        if EntityHasTag(player, "ff_hotter_fire") then
            tmax = math.min(tmax + 1, 11)
            temp = temp + 1
        end

        temp_now = math.min(temp_now + temp, math.max(tmax, temp_now))

        if temp_now ~= temp_before then

            -- 12
            local mats = {"spark_red", "spark", "spark", "spark_yellow", "spark", "spark_electric", "spark_white", "spark_blue", "spark_white_bright", "spark_player", "spark_player", "plasma_fading_pink"}
            local mat_1 = mats[math.min(temp_now + 1, #mats)]
            local mat_2 = mats[math.min(temp_now, #mats)]

            local comp_1 = EntityGetFirstComponentIncludingDisabled(effect, "ParticleEmitterComponent", "particles_1")
            if comp_1 ~= nil then
                ComponentSetValue2(comp_1, "emitted_material_name", mat_1)
            end

            local comp_2 = EntityGetFirstComponentIncludingDisabled(effect, "ParticleEmitterComponent", "particles_2")
            if comp_2 ~= nil then
                ComponentSetValue2(comp_2, "emitted_material_name", mat_2)
            end

            GameCreateCosmeticParticle(mat_1, x, y, 35, 10, -40, nil, 5, 15, true, false, true, true, 0, 80)
            GameCreateCosmeticParticle(mat_2, x, y, 60, 20, -60, nil, 5, 20, true, false, true, true, 0, 80)

        end

        ComponentSetValue2(comp_temp, "value_int", temp_now)
    end
end