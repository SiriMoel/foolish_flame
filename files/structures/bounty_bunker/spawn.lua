local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local path = "mods/foolish_flame/files/structures/bounty_bunker/"
local main_path = path .. "main.png"
local visual_path = path .. "visual.png"
local bg_path = path .. "bg.png"

LoadPixelScene(main_path, visual_path, x, y, bg_path, true)

EntityLoad("mods/foolish_flame/files/entities/items/bounty_tablet.xml", x + 80, y + 80)

EntityLoad("mods/foolish_flame/files/entities/items/lighter/item.xml", x + 200, y + 105)

EntityKill(this)