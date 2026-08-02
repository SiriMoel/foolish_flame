heat_displays = {
    {
        id = "flame",
        name = "$ff_display_flame",
        name_t = "Flame",
        sprite = "mods/foolish_flame/files/ui_gfx/heat_display/flame.png",
        sprite_hot = "mods/foolish_flame/files/ui_gfx/heat_display/flame_hot.png",
        func_unlocked = function() return true end, -- always unlocked
    },
    {
        id = "flame_animated",
        name = "$ff_display_flame_animated",
        name_t = "Flame (animated)",
        sprite = "mods/foolish_flame/files/ui_gfx/heat_display/flame_animated/1.png",
        func_unlocked = function() return true end, -- always unlocked
        custom_logic = function()
            local frame = GameGetFrameNum()
            local frames_per = 6
            local sprites = {
                "mods/foolish_flame/files/ui_gfx/heat_display/flame_animated/1.png",
                "mods/foolish_flame/files/ui_gfx/heat_display/flame_animated/2.png",
                "mods/foolish_flame/files/ui_gfx/heat_display/flame_animated/3.png",
                "mods/foolish_flame/files/ui_gfx/heat_display/flame_animated/4.png",
                "mods/foolish_flame/files/ui_gfx/heat_display/flame_animated/5.png",
                "mods/foolish_flame/files/ui_gfx/heat_display/flame_animated/6.png",
                "mods/foolish_flame/files/ui_gfx/heat_display/flame_animated/7.png",
            }
            return sprites[math.floor((frame / frames_per) % #sprites) + 1]
        end,
    },
    {
        id = "blank",
        name = "$ff_display_blank",
        name_t = "Minimalist",
        sprite = "mods/foolish_flame/files/ui_gfx/heat_display/blank.png",
        sprite_hot = "mods/foolish_flame/files/ui_gfx/heat_display/blank_hot.png",
        func_unlocked = function() return true end, -- always unlocked
    },
    {
        id = "triangle",
        name = "$ff_display_triangle",
        name_t = "Gate",
        sprite = "mods/foolish_flame/files/ui_gfx/heat_display/triangle.png",
        sprite_hot = "mods/foolish_flame/files/ui_gfx/heat_display/triangle_hot.png",
        func_unlocked = function() return true end, -- always unlocked
    },
    {
        id = "ukko",
        name = "$ff_display_ukko",
        name_t = "Ukko",
        sprite = "mods/foolish_flame/files/ui_gfx/heat_display/ukko.png",
        sprite_hot = "mods/foolish_flame/files/ui_gfx/heat_display/ukko_hot.png",
        func_unlocked = function() return true end, -- always unlocked
    },
    --[[{
        id = "special",
        name = "$ff_display_special",
        name_t = "Canto VII",
        sprite = "mods/foolish_flame/files/ui_gfx/heat_display/flame.png",
        sprite_hot = "mods/foolish_flame/files/ui_gfx/heat_display/flame_hot.png",
        func_unlocked = function() return false end, -- NOT always unlocked
    },]]
    {
        id = "gurbert",
        name = "$ff_display_gurbert",
        name_t = "Gurbert",
        sprite = "mods/foolish_flame/files/ui_gfx/heat_display/gurbert.png",
        sprite_hot = "mods/foolish_flame/files/ui_gfx/heat_display/gurbert_hot.png",
        func_unlocked = function() 
            if HasFlagPersistent("ff_gurbert_spells_unlocked") then
                return true
            end
            return false
        end,
    },
    {
        id = "copi",
        name = "$ff_display_copi",
        name_t = "Copi",
        sprite = "mods/foolish_flame/files/ui_gfx/heat_display/copi.png",
        sprite_hot = "mods/foolish_flame/files/ui_gfx/heat_display/copi_hot.png",
        func_unlocked = function() 
            if ModIsEnabled("copis_things") then
                return true
            end
            return false
        end,
    },
}

function GetDisplays()
    local t = {}
    local tr = {}
    for i=1,#heat_displays do
        local d = heat_displays[i]
        if d.func_unlocked() then
            table.insert(t, {tostring(i), d.name_t--[[GameTextGetTranslatedOrNot(d.name)]]})
            table.insert(tr, d)
        end
    end
    return t, tr
end