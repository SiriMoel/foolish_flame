dofile_once("mods/foolish_flame/files/scripts/utils.lua")

function damage_about_to_be_received(damage, x, y, entity_thats_responsible, critical_hit_chance)
    if damage > 0 then
        local this = GetUpdatedEntityID()

        local comp = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "ff_bounty_frame_damaged_last")
        if comp ~= nil then
            local frame_damaged_last = ComponentGetValue2(comp, "value_int")
            local frame_now = GameGetFrameNum()
            if not (frame_now >= frame_damaged_last + 6) then
                return 0, 0
            end
            ComponentSetValue2(comp, "value_int", frame_now)
        end

        local fire_temp = 0

        local c = EntityGetAllChildren(this, "ff_magic_fire_effect") or {}
        if #c > 0 then
            local comp_temp = EntityGetFirstComponentIncludingDisabled(c[1], "VariableStorageComponent", "fire_temp")
            if comp_temp ~= nil then
                fire_temp = ComponentGetValue2(comp_temp, "value_int")
            end
        end

        local comp_shield_temp = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "ff_bounty_shield_temp")
        if comp_shield_temp ~= nil then
            local shield_temp = ComponentGetValue2(comp_shield_temp, "value_int")
            if temp < shield_temp then
                return 0, 0
            elseif temp == shield_temp then
                damage = damage * 0.5
                critical_hit_chance = 0
            end
        end

    end

    return damage, critical_hit_chance
end

function damage_received(damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible)
    
end