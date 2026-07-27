dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

SetRandomSeed(x, y + GameGetFrameNum())

if Random(1, 10) <= 6 then -- i should add a mod setting to adjust this
    EntityLoad("mods/foolish_flame/files/entities/items/flare_wand/wand.xml", x, y)
    EntityKill(this)
end