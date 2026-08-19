local entity = GetUpdatedEntityID()

entity = EntityGetRootEntity(entity)

if entity ~= 0 then
    local x, y = EntityGetTransform(entity)

    local comp = EntityGetFirstComponentIncludingDisabled(entity, "ProjectileComponent")

    if comp ~= nil then
        local fx = EntityLoad("mods/foolish_flame/files/entities/projectiles/meltdown/spark.xml", x, y)
	    EntityAddChild(entity, fx)

        local comp_particles = EntityGetFirstComponentIncludingDisabled(fx, "ParticleEmitterComponent")

        if comp_particles ~= nil then
            local damage = ComponentGetValue2(comp, "damage") or 0

            local part_min = math.min(math.floor(damage * 1.5), 20)
            local part_max = math.min(math.ceil(damage * 1.8) + 1, 40)

            ComponentSetValue2(comp_particles, "count_min", part_min)
		    ComponentSetValue2(comp_particles, "count_max", part_max)
        end
    end
end