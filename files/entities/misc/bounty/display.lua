local this = GetUpdatedEntityID()

local x, y, r, sx, sy = EntityGetTransform(this)

local comp_shield_temp = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "ff_bounty_shield_temp")

if comp_shield_temp ~= nil then
    local shield_temp = ComponentGetValue2(comp_shield_temp, "value_int")
    local fire_temp = 0
    local c = EntityGetAllChildren(this, "ff_magic_fire_effect") or {}
    if #c > 0 then
        local comp_temp = EntityGetFirstComponentIncludingDisabled(c[1], "VariableStorageComponent", "fire_temp")
        if comp_temp ~= nil then
            fire_temp = ComponentGetValue2(comp_temp, "value_int")
        end  
    end

    local draw_x, draw_y = x, y - 40
    if fire_temp < shield_temp then
        GameCreateSpriteForXFrames("mods/foolish_flame/files/entities/misc/bounty/shield.png", draw_x, draw_y, true, 0, 0, 1, 0)
    elseif fire_temp == shield_temp then
        GameCreateSpriteForXFrames("mods/foolish_flame/files/entities/misc/bounty/shield_almost.png", draw_x, draw_y, true, 0, 0, 1, 0)
    else
        GameCreateSpriteForXFrames("mods/foolish_flame/files/entities/misc/bounty/shield_broken.png", draw_x, draw_y, true, 0, 0, 1, 0)
    end
end

local shard_comps = EntityGetComponent(this, "SpriteParticleEmitterComponent", "ff_shard")
if #shard_comps > 0 then
    local frame_now = GameGetFrameNum()
    for i=1,#shard_comps do
        local comp = shard_comps[i]

        local angle = frame_now/180 * math.pi * 2 * i/#shard_comps

        local dist = 22 + math.sin(frame_now / 16 + i * 30) * 3

        local offset_x = math.cos(angle) * dist --* sx/math.abs(sx)*-1
        local offset_y = math.sin(angle) * dist

	    ComponentSetValue2(comp, "rotation", angle*0.7)
	    ComponentSetValue2(comp, "randomize_position", offset_x, offset_y, offset_x, offset_y)
        --ComponentSetValue2(comp, "scale", sx/math.abs(sx)*-1, sy)
    end
end

--GamePrint(r .. " " .. sx .. " " .. sy)