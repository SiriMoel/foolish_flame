dofile_once("mods/foolish_flame/files/scripts/utils.lua")

function damage_about_to_be_received(damage, x, y, entity_thats_responsible, critical_hit_chance)
    if damage > 0 then
        local this = GetUpdatedEntityID()

        local comp = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "ff_bounty_frame_damaged_last")
        if comp ~= nil then
            local frame_damaged_last = ComponentGetValue2(comp, "value_int")
            local frame_now = GameGetFrameNum()
            if not (frame_now >= frame_damaged_last + 24) then
                return 0, 0
            else
                ComponentSetValue2(comp, "value_int", frame_now)
            end
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
            if fire_temp < shield_temp then
                return 0, 0
            elseif fire_temp == shield_temp then
                damage = damage * 0.5
                critical_hit_chance = critical_hit_chance * 0.2
            end
        end

        local comp_dmg = EntityGetFirstComponentIncludingDisabled(this, "DamageModelComponent")
        if comp_dmg ~= nil then
            local max_hp = ComponentGetValue2(comp_dmg, "max_hp")
            damage = math.min(damage, max_hp * 0.15)
        end
    end

    return damage, critical_hit_chance
end

function damage_received(damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible)
    if damage > 0 and not is_fatal then
        if EntityHasTag(entity_thats_responsible, "player_unit") then
            local amt = 0.2 + damage * 0.4
            RemoveHeat(amt, entity_thats_responsible)
        end
    end
end