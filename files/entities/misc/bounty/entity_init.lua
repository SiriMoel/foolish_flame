dofile_once("mods/foolish_flame/files/scripts/bounty_attacks.lua")

local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

SetRandomSeed(x, y)

if y > 20000 then
    local mult = tonumber(GlobalsGetValue("ff_bounty_chance_mult", "1")) or 1
    local r = Random(1, 100)
    local threshold = math.min(math.ceil(8 + (y - 23000)/1700), 20) * mult
    if r <= threshold then
        MakeBountyEnemy(this)
    end
end