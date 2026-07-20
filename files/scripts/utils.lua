function InflictMagicFire(target, temp, duration)
    temp = temp or 1
    duration = duration or 360

    if not EntityGetIsAlive(target) then return end

    local x, y = EntityGetTransform(target)

    local effect

    local c = EntityGetAllChildren(target, "ff_magic_fire_effect") or {}
    if #c > 0 then
        effect = c[1]
    else
        --effect = LoadGameEffectEntityTo(target, "mods/foolish_flame/files/entities/misc/status_magic_fire/effect.xml")
        --effect = LoadGameEffectEntityTo(target, "data/entities/misc/effect_ff_magic_fire.xml")
        --_, effect = GetGameEffectLoadTo(target, "FF_MAGIC_FIRE", true)
        effect = EntityLoad("mods/foolish_flame/files/entities/misc/effect_magic_fire/effect.xml", x, y)
        EntityAddChild(target, effect)
    end
    
    if effect == nil then return end -- this shouldn't happen?

    local comp_eff = EntityGetFirstComponent(effect, "GameEffectComponent")
    if comp_eff ~= nil then
        local frames = ComponentGetValue2(comp_eff, "frames")

        ComponentSetValue2(comp_eff, "frames", math.max(frames, duration))
    else
        GamePrint("FF - couldn't find GameEffectComponent :(")
    end

    local comp_temp = EntityGetFirstComponentIncludingDisabled(effect, "VariableStorageComponent", "fire_temp")
    if comp_temp ~= nil then
        local temp_before = ComponentGetValue2(comp_temp, "value_int")

        local temp_now = temp_before --math.max(temp_before, temp)
        --if temp >= temp_before then
            temp_now = math.min(temp_now + 1, 10)
        --end

        if temp_now ~= temp_before then

            local mats = {"spark_red", "spark", "spark", "spark_yellow", "spark", "spark_electric", "spark_white", "spark_blue", "spark_white_bright", "spark_player"}
            local mat_1 = mats[math.min(math.floor(#mats / 10 * temp_now) + 1, 10)]
            local mat_2 = mats[math.min(math.floor(#mats / 10 * temp_now), 10)]

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

    else
        GamePrint("FF - couldn't find temp component :(")
    end
    
end