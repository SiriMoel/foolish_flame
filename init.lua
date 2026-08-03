dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local nxml = dofile_once("mods/foolish_flame/lib/nxml.lua")

-- create heat display sprites ... if changing steps, remember to update heat_display.lua
local steps_x = 8 -- 1, 2, 4, 8
local steps_y = 20
local template, w, h = ModImageMakeEditable("mods/foolish_flame/files/ui_gfx/heat_display/full.png", 20, 34)
local step_upto = 0
for step_y=1,steps_y do
	for step_x=1,steps_x do
		local image =  ModImageMakeEditable("mods/foolish_flame/files/ui_gfx/heat_display/generated/" .. step_upto ..".png", 20, 34)
		local final_y = h - 5 - (step_y - 1)
		for y=h,final_y,-1 do
			local final_x = w - 1
			if y == final_y then
				final_x = w - 8 - 8 + step_x * (8 / steps_x)
			end
			for x=0,final_x do
				ModImageSetPixel(image, x, y, ModImageGetPixel(template, x, y))
			end
		end
		step_upto = step_upto + 1
	end
end

-- appends
ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/foolish_flame/files/scripts/gun/actions.lua")
ModLuaFileAppend("data/scripts/gun/gun.lua", "mods/foolish_flame/files/scripts/gun/gun_append.lua")
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/foolish_flame/files/scripts/perk_list.lua")

-- in grahamth we trust (i didn't know how to do this)
local content = ModTextFileGetContent("data/scripts/gun/procedural/starting_wand.lua")
content = content:gsub("\"SPITTER\"", "\"SPITTER\",\"FF_SPARKLE\"")
ModTextFileSetContent("data/scripts/gun/procedural/starting_wand.lua", content)

-- translations
local translations = ModTextFileGetContent("data/translations/common.csv")
if translations ~= nil then
    while translations:find("\r\n\r\n") do
        translations = translations:gsub("\r\n\r\n","\r\n")
    end
    local new_translations = ModTextFileGetContent(table.concat({"mods/foolish_flame/files/translations.csv"}))
    translations = translations .. new_translations
    ModTextFileSetContent("data/translations/common.csv", translations)
end

function OnModPostInit()
	local wand_good_2_path = "data/entities/items/wands/wand_good/wand_good_2.xml"
	local xml = nxml.parse(ModTextFileGetContent(wand_good_2_path))
	xml:add_child(nxml.parse(([[
    	<LuaComponent
			_enabled="1" 
        	execute_on_added="1"
        	remove_after_executed="1"
        	script_source_file="mods/foolish_flame/files/scripts/spawn_flare_wand.lua" 
		></LuaComponent>
	]])))
	ModTextFileSetContent(wand_good_2_path, tostring(xml))

	local boss_pit_path = "data/entities/animals/boss_pit/boss_pit.xml"
	local xml = nxml.parse(ModTextFileGetContent(boss_pit_path))
	xml:add_child(nxml.parse(([[
    	<LuaComponent 
			script_death="mods/foolish_flame/files/scripts/boss_pit_death.lua">
		</LuaComponent>
	]])))
	ModTextFileSetContent(boss_pit_path, tostring(xml))

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
	for i,v in ipairs(projectiles_to_modify) do
		local xml = nxml.parse(ModTextFileGetContent(v))
		xml:add_child(nxml.parse(([[
    		<HitEffectComponent 
        		effect_hit="LOAD_CHILD_ENTITY"
        		value_string="mods/foolish_flame/files/entities/misc/effect_magic_fire/init.xml">
			</HitEffectComponent>
		]])))
		ModTextFileSetContent(v, tostring(xml))
	end

	local modify_add_small_magic_fire_radius = {
		"data/entities/misc/custom_cards/torch.xml", -- this applies to apotheosis fire charge spell because they use the same card entity?
	}
	for i,v in ipairs(modify_add_small_magic_fire_radius) do
		local xml = nxml.parse(ModTextFileGetContent(v))
		xml:add_child(nxml.parse(([[
    		<LuaComponent
				_tags="enabled_in_hand,item_identified"
				script_source_file="mods/foolish_flame/files/scripts/inflict_fire_radius_small.lua"
				execute_every_n_frame="20"
			></LuaComponent>
		]])))
		ModTextFileSetContent(v, tostring(xml))
	end

	local modify_add_heat_in_inventory = {
		"data/entities/items/pickup/brimstone.xml",
	}
	for i,v in ipairs(modify_add_heat_in_inventory) do
		local xml = nxml.parse(ModTextFileGetContent(v))
		xml:add_child(nxml.parse(([[
    		<LuaComponent
				_tags="enabled_in_hand,enabled_in_inventory"
				script_source_file="mods/foolish_flame/files/scripts/heat_in_inventory.lua"
				execute_every_n_frame="15"
			></LuaComponent>
		]])))
		ModTextFileSetContent(v, tostring(xml))
	end

	local modify_sun = {
		"data/entities/items/pickup/sun/newsun.xml",
		"data/entities/items/pickup/sun/newsun_dark.xml",
	}
	for i,v in ipairs(modify_sun) do
		local xml = nxml.parse(ModTextFileGetContent(v))
		xml:add_child(nxml.parse(([[
    		<LuaComponent
				script_source_file="mods/foolish_flame/files/scripts/sun_aura.lua"
				execute_every_n_frame="15"
			></LuaComponent>
		]])))
		ModTextFileSetContent(v, tostring(xml))
	end

	local modify_bounty_enemies = {
		"data/entities/animals/the_end/gazer.xml",
		"data/entities/animals/the_end/spitmonster.xml",
		--"data/entities/animals/the_end/bloodcrystal_physics.xml",
		"data/entities/animals/the_end/worm_end.xml",
		"data/entities/animals/wraith.xml",
		"data/entities/animals/wraith_glowing.xml",
		"data/entities/animals/thunderskull.xml",
	}
	if ModIsEnabled("Apotheosis") then
		table.insert(modify_bounty_enemies, "data/entities/animals/the_end/wizard_firemage_greater.xml")
		table.insert(modify_bounty_enemies, "data/entities/animals/the_end/gazer_greater.xml")
	end
	if ModIsEnabled("souls") then -- if i must
		table.insert(modify_bounty_enemies, "data/entities/animals/the_end/moldos_soul_angry.xml")
	end
	for i,v in ipairs(modify_bounty_enemies) do
		local xml = nxml.parse(ModTextFileGetContent(v))
		xml:add_child(nxml.parse(([[
    		<LuaComponent
				script_source_file="mods/foolish_flame/files/entities/misc/bounty/entity_init.lua"
				execute_every_n_frame="1"
				remove_after_executed="1"
			></LuaComponent>
		]])))
		ModTextFileSetContent(v, tostring(xml))
	end
end

function OnPlayerSpawned(player)
	local x, y = EntityGetTransform(player)

	if GameHasFlagRun("ff_init") then return end
	GameAddFlagRun("ff_init")

	--GlobalsSetValue("ff_heat_display", tostring(ModSettingGet("foolish_flame.heat_display")))

	EntityAddComponent2(player, "VariableStorageComponent", {
		_tags="ff_heat",
		name="ff_heat",
		value_float=0.0
	})

	EntityAddComponent2(player, "LuaComponent", {
		script_source_file="mods/foolish_flame/files/scripts/heat_loss.lua",
		execute_every_n_frame=15
	})

	EntityAddComponent2(player, "LuaComponent", {
		script_source_file="mods/foolish_flame/files/scripts/heat_display.lua",
		execute_every_n_frame=1
	})

	EntityAddComponent2(player, "LuaComponent", {
		script_shot="mods/foolish_flame/files/scripts/shot.lua",
		execute_every_n_frame=-1
	})
end

function OnPausedChanged(is_paused, is_inventory_pause)
    --[[if is_paused then
		GlobalsSetValue("ff_heat_display", tostring(ModSettingGet("foolish_flame.heat_display")))
	end]]
end
