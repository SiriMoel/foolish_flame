dofile_once("mods/foolish_flame/files/scripts/utils.lua")

function damage_received(damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible)
    if damage > 0 and EntityHasTag(entity_thats_responsible, "player_unit") then
        local this = GetUpdatedEntityID()
        local entity = EntityGetParent(this)
        local amt = 2
        amt = amt * math.min(FramesSinceLastHeated(entity_thats_responsible) / 60, 1)
        AddHeat(amt, entity_thats_responsible)
    end
end