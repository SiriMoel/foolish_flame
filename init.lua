dofile_once("mods/foolish_flame/files/scripts/utils.lua")

-- appends
ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/foolish_flame/files/scripts/gun/actions.lua")
ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/foolish_flame/files/scripts/status_list.lua")

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

-- pixel scenes (from Graham, a long time ago...)
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
    --{ x, y, path, spawn_in_pws? },
}
add_scene(scenes)

function OnModPreInit()
	local steps = 20
	local template, w, h = ModImageMakeEditable("mods/foolish_flame/files/ui_gfx/fire_display/full.png", 20, 34)
	for i=0,steps do
		local image = ModImageMakeEditable("mods/foolish_flame/files/ui_gfx/fire_display/generated/" .. i ..".png", 20, 34)
		for x=0,w-1 do
			for y = 10 + steps - i, 30 do
				ModImageSetPixel(image, x, y,  ModImageGetPixel(template, x, y))
			end
		end
	end
end

-- player
function OnPlayerSpawned(player)

	local x, y = EntityGetTransform(player)

	if GameHasFlagRun("ff_init") then return end
	GameAddFlagRun("ff_init")

	EntityAddComponent(player, "VariableStorageComponent", {
		_tags="ff_heat",
		name="ff_heat",
		value_float=0.0
	})

	EntityAddComponent(player, "LuaComponent", {
		script_source_file="mods/foolish_flame/files/scripts/heat_loss.lua",
		execute_every_n_frame=30
	}) -- heat loss

	EntityAddComponent(player, "LuaComponent", {
		script_source_file="mods/foolish_flame/files/scripts/fire_display.lua",
		execute_every_n_frame=1
	}) -- fire display

end

function OnPausedChanged(is_paused, is_inventory_pause)
    if is_paused then

	end
end
