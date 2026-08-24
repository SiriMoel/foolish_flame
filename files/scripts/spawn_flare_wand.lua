dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

SetRandomSeed(x, y + GameGetFrameNum())

local chance = tonumber(GlobalsGetValue("ff_flare_wand_spawn_chance", "60")) or 60

if Random(1, 100) <= chance then
    EntityLoad("mods/foolish_flame/files/entities/items/flare_wand/wand.xml", x, y)
    EntityKill(this)
end