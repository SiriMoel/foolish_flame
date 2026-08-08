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
}

for i,v in ipairs(ff_to_add) do
    table.insert(special_spawnables, v)
end