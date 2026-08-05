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
        chance = 0.1,
        spawn_func = function(x, y)
            CreateItemActionEntity("FF_LASER", x, y - 6)
            AddFlagPersistent("ff_laser_unlocked")
        end,
    },
}

--[[
    this is NYI
    need to make the function to pick based on chances
]]

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