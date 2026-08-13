dofile_once("data/scripts/perks/perk.lua")

bounty_rewards = {
    {
        id = "nothing",
        chance = 2.2, -- should there even be a chance to get nothing?
        spawn_func = function(x, y)
            -- this is "air"? so... nothing...
        end,
    },
    {
        id = "gold",
        chance = 4.0,
        spawn_func = function(x, y)
            SetRandomSeed(x, y)
            for i=1,Random(3, 6) do
		        EntityLoad("data/entities/items/pickup/goldnugget_200.xml", x - 9 + i * 3, y - 2)
	        end
        end,
    },
    {
        id = "t10_spell",
        chance = 6.0,
        spawn_func = function(x, y)
            SetRandomSeed(x, y)
            local action = GetRandomAction(x, y, 10, 0)
            CreateItemActionEntity(action, x, y - 6)
        end,
    },
    {
        id = "twospells",
        chance = 3.0,
        spawn_func = function(x, y)
            SetRandomSeed(x, y)
            CreateItemActionEntity(GetRandomAction(x, y, 6, 0), x - 10, y - 6)
            CreateItemActionEntity(GetRandomAction(x, y, 10, 0), x + 10, y - 6)
        end,
    },
    {
        id = "laser",
        chance = 0.5, -- ?
        spawn_func = function(x, y)
            CreateItemActionEntity("FF_LASER", x, y - 6)
            AddFlagPersistent("ff_laser_unlocked")
        end,
    },
    {
        id = "taq_pol",
        chance = 2.5,
        spawn_func = function(x, y)
            EntityLoad("mods/foolish_flame/files/entities/items/taq_pol/item.xml", x, y - 4)
        end,
    },
    {
        id = "willowslighter",
        chance = 0.1,
        spawn_func = function(x, y)
            EntityLoad("mods/foolish_flame/files/entities/items/willows_lighter/item.xml", x, y - 4)
        end,
    },
    {
        id = "sword",
        chance = 0.4,
        spawn_func = function(x, y)
            EntityLoad("mods/foolish_flame/files/entities/items/sword/item.xml", x, y - 4)
        end,
    },
    {
        id = "bountyperk",
        chance = 0.6,
        spawn_func = function(x, y)
            local player = EntityGetWithTag("player_unit")[1]
            if not EntityHasTag(player, "ff_extra_bounty_reward") then
                perk_spawn(x, y - 6, "FF_EXTRA_BOUNTY_REWARD")
            else
                SetRandomSeed(x, y)
                local action = GetRandomAction(x, y, 10, 0)
                CreateItemActionEntity(action, x, y - 6)
            end
        end,
    },
    {
        id = "flarewand",
        chance = 0.6,
        spawn_func = function(x, y)
            local wand = EntityLoad("mods/foolish_flame/files/entities/items/flare_wand/wand.xml", x, y - 4)
            local comp = EntityGetFirstComponentIncludingDisabled(wand, "LuaComponent", "towerwandpickupscript")
            if comp ~= nil then
                EntityRemoveComponent(wand, comp)
            end
        end,
    },
    {
        id = "heartlighter",
        chance = 0.4,
        spawn_func = function(x, y)
            EntityLoad("mods/foolish_flame/files/entities/items/heart_lighter/item.xml", x, y - 4)
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

function RewardsTest(amt)
    local chance_total = 0.0
    for i,v in ipairs(bounty_rewards) do
        v.chance_min = chance_total
        v.chance_max = chance_total + v.chance
        chance_total = v.chance_max
    end
    local rewards = {}
    for i=1,amt do
        local num = Random(0, math.floor(chance_total)) + 0.1 * Random(0, (chance_total - math.floor(chance_total)) * 10)
        for _,v in ipairs(bounty_rewards) do
            if num >= v.chance_min and num < v.chance_max then
                table.insert(rewards, v.id)
                break
            end
        end
    end
    --[[local str = "Picked " .. amt .. " bounty rewards:"
    for i,v in ipairs(rewards) do
        str = str .. " " .. v
    end
    print(str)]]
    local counts = {}
    for i,v in ipairs(rewards) do
        if type(counts[tostring(v)]) == "number" then
            counts[tostring(v)] = counts[tostring(v)] + 1
        else
            counts[tostring(v)] = 1
        end
    end
    print("FF RewardsTest(" .. amt .. ") RESULTS...")
    for k,v in pairs(counts) do
        print(tostring(k) .. ": " .. v)
    end
    print("okay done :)")
end