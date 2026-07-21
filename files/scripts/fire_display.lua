dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local player = GetUpdatedEntityID()

local heat = GetHeat(player)

if heat > 0 then
    local px, py = EntityGetTransform(player)
    local draw_x, draw_y = px, py - 38

    local frames = 1

    GameCreateSpriteForXFrames("mods/foolish_flame/files/ui_gfx/fire_display/flame.png", draw_x, draw_y, true, 0, 0, frames, 0)
        
    --heat = GameGetFrameNum()/10 --testing

    local step = math.min(math.floor((heat / 200) * 32), 32)

    GameCreateSpriteForXFrames("mods/foolish_flame/files/ui_gfx/fire_display/generated/" .. step .. ".png", draw_x, draw_y, true, 0, 0, frames, 0)
end