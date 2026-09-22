if not (GlobalsGetValue("ff_show_heat_gauge", "true") == "true") then return end

dofile_once("mods/foolish_flame/files/scripts/utils.lua")
dofile_once("mods/foolish_flame/files/scripts/gauges.lua")

local _,available_displays = GetGauges()

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
            ModSettingSet("foolish_flame.heat_gauge", num)
        end
    end
end

local player = GetUpdatedEntityID()

local heat = GetHeat(player)

if heat > 0 or (frame ~= nil and (frame < frame_last + 60)) then
    local px, py = EntityGetTransform(player)
    local draw_x, draw_y = px, py - 42

    local frames = 1

    local display = available_displays[tonumber(GlobalsGetValue("ff_heat_display", "1"))] or heat_gauges[1]

    local draw_order = display.draw_order or {"SPRITE", "STEP"}

    local sprites = {
        SPRITE = display.sprite,
        STEP = nil,
    }

    local step_count = 8 * 20 - 1
    local step = math.min(math.floor((heat / 300) * step_count), step_count)

    if display.custom_logic ~= nil then
        sprites = display.custom_logic(heat)
    else
        if heat >= 400 and display.sprite_hot ~= nil then
            sprites["SPRITE"] = display.sprite_hot
        else
            sprites["SPRITE"] = display.sprite
        end
    end

    if sprites["STEP"] == nil then
        sprites["STEP"] = "mods/foolish_flame/files/ui_gfx/heat_display/generated/" .. step .. ".png"
    end

    for i,v in ipairs(draw_order) do
        local sprite = sprites[v]
        if sprite ~= nil then
            GameCreateSpriteForXFrames(sprite, draw_x, draw_y, true, 0, 0, frames, 0)
        end
    end
end