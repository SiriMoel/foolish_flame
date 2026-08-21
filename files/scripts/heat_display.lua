dofile_once("mods/foolish_flame/files/scripts/utils.lua")
dofile_once("mods/foolish_flame/files/scripts/displays.lua")

local _,available_displays = GetDisplays()

local button_left_down = InputIsKeyDown(47)
local button_right_down = InputIsKeyDown(48)
local frame_last
local frame
local changed = false
if button_left_down or button_right_down then
    frame_last = tonumber(GlobalsGetValue("ff_display_frame", "0"))
    frame = GameGetFrameNum()
    if frame > frame_last + 10 then
        local num = tonumber(GlobalsGetValue("ff_heat_display", "1"))
        changed = false
        if button_left_down then
            num = num - 1
            if num <= 0 then
                num = #available_displays
            end
            changed = true
        elseif button_right_down then
            num = num + 1
            if num > #available_displays then
                num = 1
            end
            changed = true
        end
        if changed then
            GlobalsSetValue("ff_heat_display", tostring(num))
            GlobalsSetValue("ff_display_frame", tostring(frame))
            GamePrint("Now using \"" .. GameTextGetTranslatedOrNot(available_displays[num].name) .. "\" heat gauge.")
        end
    end
end

local player = GetUpdatedEntityID()

local heat = GetHeat(player)

if heat > 0 or (frame ~= nil and (frame < frame_last + 60)) then
    local px, py = EntityGetTransform(player)
    local draw_x, draw_y = px, py - 42

    local frames = 1

    local display = available_displays[tonumber(GlobalsGetValue("ff_heat_display", "1"))] or heat_displays[1]
    --GamePrint(#heat_displays)

    local sprite = display.sprite

    if display.custom_logic ~= nil then
        sprite = display.custom_logic(heat)
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