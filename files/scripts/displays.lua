heat_displays = {
    {
        id = "flame",
        name = "$ff_display_flame",
        sprite = "mods/foolish_flame/files/ui_gfx/heat_display/flame.png",
        sprite_hot = "mods/foolish_flame/files/ui_gfx/heat_display/flame_hot.png",
        func_unlocked = function() return true end,
    },
    {
        id = "gurbert",
        name = "$ff_display_gurbert",
        sprite = "mods/foolish_flame/files/ui_gfx/heat_display/gurbert.png",
        sprite_hot = "mods/foolish_flame/files/ui_gfx/heat_display/gurbert_hot.png",
        func_unlocked = function() return true end,
    },
    --[[{
        id = "triangle",
        name = "$ff_display_triangle",
        sprite = "mods/foolish_flame/files/ui_gfx/heat_display/flame.png",
        sprite_hot = "mods/foolish_flame/files/ui_gfx/heat_display/flame_hot.png",
        func_unlocked = function() return true end,
    },]]
    --[[{
        id = "ukko",
        name = "$ff_display_ukko",
        sprite = "mods/foolish_flame/files/ui_gfx/heat_display/flame.png",
        sprite_hot = "mods/foolish_flame/files/ui_gfx/heat_display/flame_hot.png",
        func_unlocked = function() return true end,
    },]]
    --[[{
        id = "special",
        name = "$ff_display_special",
        sprite = "mods/foolish_flame/files/ui_gfx/heat_display/flame.png",
        sprite_hot = "mods/foolish_flame/files/ui_gfx/heat_display/flame_hot.png",
        func_unlocked = function() return false end,
    },]]
    {
        id = "copi",
        name = "$ff_display_copi",
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
            table.insert(t, {tostring(i), GameTextGetTranslatedOrNot(d.name)})
        end
    end
    return t
end