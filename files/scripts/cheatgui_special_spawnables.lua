local ff_to_add = {
    {
        path = "mods/foolish_flame/files/entities/items/willows_lighter/item.xml",
        name = "Willow's Lighter",
        xml = "item.xml",
    },
    {
        path = "mods/foolish_flame/files/entities/items/taq_pol/item.xml",
        name = "Taq Pol",
        xml = "item.xml",
    },
    {
        path = "mods/foolish_flame/files/entities/items/flare_wand/wand.xml",
        name = "Wand of Magic Fire",
        xml = "wand.xml",
    },
    {
        path = "mods/foolish_flame/files/entities/items/sword/item.xml",
        name = "foolish flame sword",
        xml = "item.xml",
    },
    {
        path = "mods/foolish_flame/files/entities/items/lighter/item.xml",
        name = "Lighter",
        xml = "item.xml",
    },
    {
        path = "mods/foolish_flame/files/entities/gurbert/gurbert.xml",
        name = "Gurbert",
        xml = "gurbert.xml",
    },
    {
        path = "mods/foolish_flame/files/structures/bounty_bunker/spawner.xml",
        name = "Bounty Bunker",
        xml = "spawner.xml",
    },
}

for i,v in ipairs(ff_to_add) do
    table.insert(special_spawnables, v)
end