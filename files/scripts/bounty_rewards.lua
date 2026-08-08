bounty_rewards = {
    {
        chance = 4.0,
        spawn_func = function(x, y)
            -- this is "air"? so... nothing...
        end,
    },
    {
        chance = 3.0,
        spawn_func = function(x, y)
            SetRandomSeed(x, y)
            for i=1,Random(3, 6) do
		        EntityLoad("data/entities/items/pickup/goldnugget_200.xml", x - 9 + i * 3, y - 2)
	        end
        end,
    },
    {
        chance = 4.0,
        spawn_func = function(x, y)
            SetRandomSeed(x, y)
            local action = GetRandomAction(x, y, 10, 0)
            CreateItemActionEntity(action, x, y - 6)
        end,
    },
    {
        chance = 1.2,
        spawn_func = function(x, y)
            SetRandomSeed(x, y)
            CreateItemActionEntity(GetRandomAction(x, y, 6, 0), x - 10, y - 6)
            CreateItemActionEntity(GetRandomAction(x, y, 10, 0), x + 10, y - 6)
        end,
    },
    {
        chance = 0.2,
        spawn_func = function(x, y)
            CreateItemActionEntity("FF_LASER", x, y - 6)
            AddFlagPersistent("ff_laser_unlocked")
        end,
    },
    --[[{
        chance = 0.7,
        spawn_func = function(x, y)
            SetRandomSeed(x, y)
            perk_spawn_random(x, y) -- needs data/scripts/perk/perk.lua
        end,
    },]]
    {
        chance = 1.6,
        spawn_func = function(x, y)
            EntityLoad("mods/foolish_flame/files/entities/items/taq_pol/item.xml", x, y - 4)
        end,
    },
    {
        chance = 0.2,
        spawn_func = function(x, y)
            EntityLoad("mods/foolish_flame/files/entities/items/willows_lighter/item.xml", x, y - 4)
        end,
    },
}

function BountyReward(x, y)
    SetRandomSeed(x, y)

    local chance_total = 0.0

    for i,v in ipairs(bounty_rewards) do
        v.chance_min = chance_total
        v.chance_max = chance_total + v.chance
        chance_total = v.chance_max
    end

    local num = Random(0, math.floor(chance_total)) + 0.1 * Random(0, (chance_total - math.floor(chance_total)) * 10)

    for i,v in ipairs(bounty_rewards) do
        if num >= v.chance_min and num < v.chance_max then
            v.spawn_func(x, y)
            break
        end
    end
end