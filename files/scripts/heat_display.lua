dofile_once("mods/foolish_flame/files/scripts/utils.lua")
dofile_once("mods/foolish_flame/files/scripts/displays.lua")

local player = GetUpdatedEntityID()

local heat = GetHeat(player)

if heat > 0 then
    local px, py = EntityGetTransform(player)
    local draw_x, draw_y = px, py - 42

    local frames = 1

    local display = heat_displays[tonumber(GlobalsGetValue("ff_heat_display", "1"))] or heat_displays[1]

    local sprite = display.sprite

    if display.custom_logic ~= nil then
        sprite = display.custom_logic()
    else
        if heat >= 400 and display.sprite_hot ~= nil then
            sprite = display.sprite_hot
        end
    end

    GameCreateSpriteForXFrames(sprite, draw_x, draw_y, true, 0, 0, frames, 0)
    
    local step_count = 8 * 20 - 1

    local step = math.min(math.floor((heat / 300) * step_count), step_count)

    GameCreateSpriteForXFrames("mods/foolish_flame/files/ui_gfx/heat_display/generated/" .. step .. ".png", draw_x, draw_y, true, 0, 0, frames, 0)
end