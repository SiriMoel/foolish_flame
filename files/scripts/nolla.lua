local entity = GetUpdatedEntityID()
entity = EntityGetRootEntity(entity)
if entity ~= 0 then
    EntityAddTag(entity, "ff_nollad")
end