local nxml = dofile_once("mods/foolish_flame/lib/nxml.lua")

for content in nxml.edit_file("data/entities/items/pickup/brimstone.xml") do
    content:create_children(
	    { VariableStorageComponent = {
    		_tags="ff_inventory_heater,enabled_in_inventory,enabled_in_hand",
		    name="ff_inventory_heater",
		    value_float=5
	    }}
    )
end

for content in nxml.edit_file("data/entities/items/wands/wand_good/wand_good_2.xml") do
    content:create_children(
	    { LuaComponent = {
    		_enabled=true,
        	execute_on_added=true,
        	remove_after_executed=true,
        	script_source_file="mods/foolish_flame/files/scripts/spawn_flare_wand.lua" 
	    }}
    )
end

for content in nxml.edit_file("data/entities/animals/boss_pit/boss_pit.xml") do
    content:create_children(
	    { LuaComponent = {
    		script_death="mods/foolish_flame/files/scripts/boss_pit_death.lua"
	    }}
    )
end

for content in nxml.edit_file("data/entities/misc/nolla.xml") do
    content:create_children(
	    { LuaComponent = {
    		execute_on_added=true,
        	remove_after_executed=true,
        	script_source_file="mods/foolish_flame/files/scripts/nolla.lua" 
	    }}
    )
end

local projectiles_to_modify = {
	"data/entities/projectiles/deck/grenade_large.xml",
	"data/entities/projectiles/deck/lance_holy.xml",		
}
if ModIsEnabled("grahamsperks") then
	table.insert(projectiles_to_modify, "mods/grahamsperks/files/spells/willowisp.xml") -- ignis fatuus
	table.insert(projectiles_to_modify, "mods/grahamsperks/files/spells/infernal_glare_beam.xml")
end
if ModIsEnabled("copis_things") then
	table.insert(projectiles_to_modify, "mods/copis_things/files/entities/projectiles/infernal_streak.xml")
	table.insert(projectiles_to_modify, "mods/copis_things/files/entities/projectiles/firesphere.xml")
end
if ModIsEnabled("Apotheosis") then -- why is it capitalised...
	table.insert(projectiles_to_modify, "mods/Apotheosis/files/entities/projectiles/deck/wall_of_fire.xml")
end
if ModIsEnabled("souls") then
	table.insert(projectiles_to_modify, "mods/souls/files/entities/projectiles/tome_shot/proj.xml")
	table.insert(projectiles_to_modify, "mods/souls/files/entities/projectiles/tome_seek/proj.xml")
end
for _,path in ipairs(projectiles_to_modify) do
    for content in nxml.edit_file(path) do
        content:create_children(
	        { HitEffectComponent = {
    		    effect_hit="LOAD_CHILD_ENTITY",
        		value_string="mods/foolish_flame/files/entities/misc/effect_magic_fire/init.xml"
	        }}
        )
    end
end

local modify_add_small_magic_fire_radius = {
	"data/entities/misc/custom_cards/torch.xml", -- this applies to apotheosis fire charge spell because they use the same card entity?
}
if ModIsEnabled("souls") then
	table.insert(modify_add_small_magic_fire_radius, "mods/souls/files/entities/misc/card_soul_fire/card.xml")
end
for _,path in ipairs(modify_add_small_magic_fire_radius) do
    for content in nxml.edit_file(path) do
        content:create_children(
	        { LuaComponent = {
    		    _tags="enabled_in_hand,item_identified",
				script_source_file="mods/foolish_flame/files/scripts/inflict_fire_radius_small.lua",
				execute_every_n_frame=20
	        }}
        )
    end
end

local suns = {
    "data/entities/items/pickup/sun/newsun.xml",
	"data/entities/items/pickup/sun/newsun_dark.xml",
}
for _,path in ipairs(suns) do
    for content in nxml.edit_file(path) do
        content:set("tags", content:get("tags") .. ",ff_sun")
    end
end

local bounty_enemies = {
    "data/entities/animals/the_end/gazer.xml",
	"data/entities/animals/the_end/spitmonster.xml",
	"data/entities/animals/the_end/worm_end.xml",
	"data/entities/animals/wraith.xml",
	"data/entities/animals/wraith_glowing.xml",
	"data/entities/animals/thunderskull.xml",
}
if ModIsEnabled("Apotheosis") then
	table.insert(bounty_enemies, "data/entities/animals/the_end/wizard_firemage_greater.xml")
	table.insert(bounty_enemies, "data/entities/animals/the_end/gazer_greater.xml")
end
for _,path in ipairs(bounty_enemies) do
    for content in nxml.edit_file(path) do
        content:create_children(
	        { LuaComponent = {
    		    script_source_file="mods/foolish_flame/files/entities/misc/bounty/entity_init.lua",
				execute_every_n_frame=1,
				remove_after_executed=true
	        }}
        )
    end
end