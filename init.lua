dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local nxml = dofile_once("mods/foolish_flame/lib/nxml.lua")

ModMaterialsFileAdd("mods/foolish_flame/files/materials.xml")

-- create heat display sprites ... if changing steps, remember to update heat_gauge.lua
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
--ModLuaFileAppend("data/scripts/status_effects/status_list.lua", "mods/foolish_flame/files/scripts/status_list.lua")

local content = ModTextFileGetContent("data/scripts/gun/procedural/starting_wand.lua")
content = content:gsub("\"SPITTER\"", "\"SPITTER\",\"FF_SPARKLE\"")
ModTextFileSetContent("data/scripts/gun/procedural/starting_wand.lua", content)

dofile_once("mods/foolish_flame/files/scripts/gizmo.lua")

-- in grahamth we trust
local function add_scene(table)
	local biome_path = ModIsEnabled("noitavania") and "mods/noitavania/data/biome/_pixel_scenes.xml" or "data/biome/_pixel_scenes.xml"
	local content = ModTextFileGetContent(biome_path)
	local string = "<mBufferedPixelScenes>"
	local worldsize = ModTextFileGetContent("data/compatibilitydata/worldsize.txt") or 35840
	for i = 1, #table do
		string = string .. [[<PixelScene pos_x="]] .. table[i][1] .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
		if table[i][4] then
			-- make things show up in first 2 parallel worlds
			-- hopefully this won't cause too much lag when starting a run
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] + worldsize .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] - worldsize .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] + worldsize * 2 .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
			string = string .. [[<PixelScene pos_x="]] .. table[i][1] - worldsize * 2 .. [[" pos_y="]] .. table[i][2] .. [[" just_load_an_entity="]] .. table[i][3] .. [["/>]]
		end
	end
	content = content:gsub("<mBufferedPixelScenes>", string)
	ModTextFileSetContent(biome_path, content)
end
local scenes = {
    {2850, 17425, "mods/foolish_flame/files/structures/bounty_bunker/spawner.xml", false},
}
add_scene(scenes)

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
	if ModIsEnabled("cheatgui") then
		ModLuaFileAppend("data/hax/special_spawnables.lua", "mods/foolish_flame/files/scripts/cheatgui_special_spawnables.lua")
	end
end

function OnPlayerSpawned(player)
	local x, y = EntityGetTransform(player)

	local spooky = false
	local year, month, day = GameGetDateAndTimeLocal()
    if month == 10 then
		spooky = true
		GameAddFlagRun("ff_spooky")
	end

	if GameHasFlagRun("ff_init") then return end
	GameAddFlagRun("ff_init")

	if spooky then
        GamePrint("Spooky flame...")
    end

	local gauge = ModSettingGet("foolish_flame.heat_gauge") or 1
	GlobalsSetValue("ff_heat_display", tostring(gauge))

	if HasFlagPersistent("ff_died_with_willows_lighter") then
		EntityLoad("mods/foolish_flame/files/entities/items/willows_lighter/item.xml", x + 6, y)
		RemoveFlagPersistent("ff_died_with_willows_lighter")
	end

	GlobalsSetValue("ff_show_heat_gauge", tostring(ModSettingGet("foolish_flame.show_heat_gauge")))
	GlobalsSetValue("ff_flare_wand_spawn_chance", tostring(ModSettingGet("foolish_flame.flare_wand_spawn_chance")))
	--GlobalsSetValue("ff_heat_loss_mult", tostring(ModSettingGet("foolish_flame.heat_loss_mult")))
	--GlobalsSetValue("ff_brimstone_heat", tostring(ModSettingGet("foolish_flame.brimstone_heat")))
	GlobalsSetValue("ff_bounty_chance_mult", tostring(ModSettingGet("foolish_flame.bounty_chance_mult")))
	GlobalsSetValue("ff_heat_damage_mult", tostring(ModSettingGet("foolish_flame.heat_damage_mult")))

	EntityAddComponent2(player, "VariableStorageComponent", {
		_tags="ff_heat",
		name="ff_heat",
		value_float=0.0
	})

	EntityAddComponent2(player, "VariableStorageComponent", {
		_tags="ff_frame_last_heated",
		name="ff_frame_last_heated",
		value_int=0
	})

	EntityAddComponent2(player, "LuaComponent", {
		script_source_file="mods/foolish_flame/files/scripts/heat_handler.lua",
		execute_every_n_frame=12
	})

	--[[EntityAddComponent2(player, "LuaComponent", {
		script_source_file="mods/foolish_flame/files/scripts/heat_loss.lua",
		execute_every_n_frame=15
	})]]

	EntityAddComponent2(player, "LuaComponent", {
		_tags="ff_gauge",
		script_source_file="mods/foolish_flame/files/scripts/heat_gauge.lua",
		execute_every_n_frame=1
	})

	EntityAddComponent2(player, "LuaComponent", {
		script_shot="mods/foolish_flame/files/scripts/shot.lua",
		execute_every_n_frame=-1
	})

	EntityAddComponent2(player, "LuaComponent", {
		script_death="mods/foolish_flame/files/scripts/player_death.lua",
		execute_every_n_frame=-1
	})

	--dofile_once("mods/foolish_flame/files/scripts/bounty_rewards.lua") RewardsTest(5000)
end

function OnPausedChanged(is_paused, is_inventory_pause)
    if is_paused then
		local show_heat_gauge = ModSettingGet("foolish_flame.show_heat_gauge") or false
		GlobalsSetValue("ff_show_heat_gauge", tostring(show_heat_gauge))
		local flare_wand_spawn_chance = ModSettingGet("foolish_flame.flare_wand_spawn_chance") or 60
		GlobalsSetValue("ff_flare_wand_spawn_chance", tostring(flare_wand_spawn_chance))
		--local heat_loss_mult = ModSettingGet("foolish_flame.heat_loss_mult") or 1
		--GlobalsSetValue("ff_heat_loss_mult", tostring(heat_loss_mult))
		--local brimstone_heat = ModSettingGet("foolish_flame.brimstone_heat") or 4
		--GlobalsSetValue("ff_brimstone_heat", tostring(brimstone_heat))
		local bounty_chance_mult = ModSettingGet("foolish_flame.bounty_chance_mult") or 1
		GlobalsSetValue("ff_bounty_chance_mult", tostring(bounty_chance_mult))
		local heat_damage_mult = ModSettingGet("foolish_flame.heat_damage_mult") or 1
		GlobalsSetValue("ff_heat_damage_mult", tostring(heat_damage_mult))
	end
end
