bounty_rewards = {
    {
        chance = 4.0,
        spawn_func = function(x, y)
            SetRandomSeed(x, y)
            for i=1,Random(3, 6) do
		        EntityLoad("data/entities/items/pickup/goldnugget_200.xml", x - 9 + i * 3, y - 2)
	        end
        end,
    },
    {
        chance = 3.0,
        spawn_func = function(x, y)
            SetRandomSeed(x, y)
            local action = GetRandomAction(x, y, 10, 0)
            CreateItemActionEntity(action, x, y - 6)
        end,
    },
    {
        chance = 1.0,
        spawn_func = function(x, y)
            SetRandomSeed(x, y)
            local action = GetRandomAction(x, y, 6, 0)
            CreateItemActionEntity(action, x, y - 6)
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