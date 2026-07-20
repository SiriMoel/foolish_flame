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
        effect = EntityLoad("mods/foolish_flame/files/entities/misc/status_magic_fire/effect.xml", x, y)
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
        local temp_now = math.max(temp_before, temp)
        ComponentSetValue2(comp_temp, "value_int", temp_now)
        if temp_now ~= temp_before then
            -- temp change vfx. maybe some explosion & also change particle emitter colour
        end
    else
        GamePrint("FF - couldn't find temp component :(")
    end
    
end