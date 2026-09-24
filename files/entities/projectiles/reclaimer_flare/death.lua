function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)
    local e = EntityGetAllChildren(entity, "ff_magic_fire_effect") or {}
    if #e > 0 then
        local fire = e[1]
        local comp = EntityGetFirstComponentIncludingDisabled(fire, "VariableStorageComponent", "fire_temp")
        if comp ~= nil then
            local temp = ComponentGetValue2(comp, "value_int")
            local pickup = EntityLoad("mods/foolish_flame/files/entities/projectiles/reclaimer_flare/pickup.xml", x, y-2)
            local comp_amt = EntityGetFirstComponentIncludingDisabled(pickup, "VariableStorageComponent", "heat_amt")
            if comp_amt ~= nil then
                local amt = 8 + temp * 4
                ComponentSetValue2(comp_amt, "value_float", amt)
            end
            local comp_spec = EntityGetFirstComponentIncludingDisabled(pickup, "SpriteParticleEmitterComponent")
            if comp_spec ~= nil then
                ComponentSetValue2(comp_spec, "sprite_file", "mods/foolish_flame/files/entities/misc/effect_magic_fire/particles/" .. temp .. ".xml")
            end
        end
    end
end