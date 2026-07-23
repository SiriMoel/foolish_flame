dofile_once("mods/foolish_flame/files/scripts/utils.lua")
dofile_once("mods/foolish_flame/files/scripts/displays.lua")

local player = GetUpdatedEntityID()

local heat = GetHeat(player)

if heat > 0 then
    local px, py = EntityGetTransform(player)
    local draw_x, draw_y = px, py - 42

    local frames = 1

    local display_num = tonumber(GlobalsGetValue("ff_heat_display", "1"))

    if heat >= 400 then
        GameCreateSpriteForXFrames(heat_displays[display_num].sprite_hot, draw_x, draw_y, true, 0, 0, frames, 0)
    else
        GameCreateSpriteForXFrames(heat_displays[display_num].sprite, draw_x, draw_y, true, 0, 0, frames, 0)
    end
        
    local step = math.min(math.floor((heat / 300) * 40), 40)

    GameCreateSpriteForXFrames("mods/foolish_flame/files/ui_gfx/heat_display/generated/" .. step .. ".png", draw_x, draw_y, true, 0, 0, frames, 0)
end