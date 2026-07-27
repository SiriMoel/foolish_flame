heat_displays = {
    {
        id = "flame",
        name = "$ff_display_flame",
        name_t = "Flame",
        sprite = "mods/foolish_flame/files/ui_gfx/heat_display/flame.png",
        sprite_hot = "mods/foolish_flame/files/ui_gfx/heat_display/flame_hot.png",
        func_unlocked = function() return true end,
    },
    {
        id = "blank",
        name = "$ff_display_blank",
        name_t = "Minimalist",
        sprite = "mods/foolish_flame/files/ui_gfx/heat_display/blank.png",
        sprite_hot = "mods/foolish_flame/files/ui_gfx/heat_display/blank_hot.png",
        func_unlocked = function() return true end,
    },
    {
        id = "triangle",
        name = "$ff_display_triangle",
        name_t = "Gate",
        sprite = "mods/foolish_flame/files/ui_gfx/heat_display/triangle.png",
        sprite_hot = "mods/foolish_flame/files/ui_gfx/heat_display/triangle_hot.png",
        func_unlocked = function() return true end,
    },
    --[[{
        id = "ukko",
        name = "$ff_display_ukko",
        name_t = "Ukko",
        sprite = "mods/foolish_flame/files/ui_gfx/heat_display/flame.png",
        sprite_hot = "mods/foolish_flame/files/ui_gfx/heat_display/flame_hot.png",
        func_unlocked = function() return true end,
    },]]
    --[[{
        id = "special",
        name = "$ff_display_special",
        name_t = "Canto VII",
        sprite = "mods/foolish_flame/files/ui_gfx/heat_display/flame.png",
        sprite_hot = "mods/foolish_flame/files/ui_gfx/heat_display/flame_hot.png",
        func_unlocked = function() return false end,
    },]]
    {
        id = "gurbert",
        name = "$ff_display_gurbert",
        name_t = "Gurbert",
        sprite = "mods/foolish_flame/files/ui_gfx/heat_display/gurbert.png",
        sprite_hot = "mods/foolish_flame/files/ui_gfx/heat_display/gurbert_hot.png",
        func_unlocked = function() return true end,
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
    for i=1,#heat_displays do
        local d = heat_displays[i]
        if d.func_unlocked() then
            table.insert(t, {tostring(i), d.name_t--[[GameTextGetTranslatedOrNot(d.name)]]})
        end
    end
    return t
end