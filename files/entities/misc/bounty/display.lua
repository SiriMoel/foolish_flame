local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

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