function collision_trigger(colliding_entity_id)
    local this = GetUpdatedEntityID()
    local comp = EntityGetFirstComponentIncludingDisabled(this, "ProjectileComponent")
    if comp ~= nil then
        local exp_rad = ComponentObjectGetValue2(this, "config_explosion", "explosion_radius") or 0
        local radius = exp_rad + 10
        local x, y = EntityGetTransform(this)
        local targets = EntityGetInRadiusWithTag(x, y, radius, "homing_target") or {}
        if #targets > 0 then
            for i = 1, #targets do
                local target = targets[i]
                local c = EntityLoad("mods/foolish_flame/files/entities/projectiles/aoe_flare/hit_entity.xml", x, y)
                EntityAddChild(target, c)
            end
        end
    end
end