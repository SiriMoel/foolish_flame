dofile_once("mods/foolish_flame/files/scripts/bounty_attacks.lua")

local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

SetRandomSeed(x, y)

local threshold = math.min(math.ceil(8 + (y - 23000)/1700), 20)

if (y > 20000) and (Random(1, 100) <= threshold) then
    MakeBountyEnemy(this)
end