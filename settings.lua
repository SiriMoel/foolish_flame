dofile("data/scripts/lib/mod_settings.lua")
dofile("mods/foolish_flame/files/scripts/gauges.lua")

function mod_setting_bool_ff(mod_id, gui, in_main_menu, im_id, setting)
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	if type(value) ~= "boolean" then value = setting.value_default or false end

	local text = GameTextGet(value and "$ff_setting_on" or "$ff_setting_off")

    if value then
        GuiColorSetForNextWidget(gui, 1.0, 0.9, 0.7, 1.0)
    else
        GuiColorSetForNextWidget(gui, 0.4, 0.4, 0.6, 1.0)
    end

	GuiText(gui, mod_setting_group_x_offset, 0, text, 1, "", true)

    GuiColorSetForNextWidget(gui, 0.6, 0.6, 0.6, 1)

    local clicked,right_clicked = GuiButton( gui, im_id, mod_setting_group_x_offset + 24, -11, setting.ui_name )

    GuiColorSetForNextWidget(gui, 1, 1, 1, 1)

    if clicked then
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), not value, false )
		mod_setting_handle_change_callback( mod_id, gui, in_main_menu, setting, value, not value )
	end
	if right_clicked then
		local new_value = setting.value_default or false
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), new_value, false )
		mod_setting_handle_change_callback( mod_id, gui, in_main_menu, setting, value, new_value )
	end

	mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
end

--[[function mod_setting_number_ff(mod_id, gui, in_main_menu, im_id, setting)
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	if type(value) ~= "number" then value = setting.value_default or 0.0 end

	if setting.value_min == nil or setting.value_max == nil or setting.value_default == nil then
		GuiText( setting.ui_name .. " - not all required values are defined in setting definition" )
		return
	end

    local r, g, b = 1, 1, 1
    local m = setting.value_min / setting.value_max
    r = 0.7 + 0.3 * m
    g = 0.6 + 0.3 * m
    b = 0.4 + 0.3 * m
    GuiColorSetForNextWidget(gui, r, g, b, 1)

	local value_new = GuiSlider(gui, im_id, mod_setting_group_x_offset, 0, "", value, setting.value_min, setting.value_max, setting.value_default, setting.value_display_multiplier or 1, setting.value_display_formatting or "", 40)
	if value ~= value_new then
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), value_new, false )
		mod_setting_handle_change_callback( mod_id, gui, in_main_menu, setting, value, value_new )
	end

    GuiColorSetForNextWidget(gui, 0.6, 0.6, 0.6, 1)

    GuiText(gui, mod_setting_group_x_offset + 44, -10, setting.ui_name, 1, "", true)

    GuiColorSetForNextWidget(gui, 1, 1, 1, 1)

	mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
end]]

function mod_setting_enum_ff(mod_id, gui, in_main_menu, im_id, setting)
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	if type(value) ~= "string" then value = setting.value_default or "" end

	local value_id = 1
	for i,val in ipairs(setting.values) do
		if val[1] == value then
			value_id = i
			break
		end
	end

	local text = setting.values[value_id][2]

    local p = value_id / #setting.values

    GuiColorSetForNextWidget(gui, 0.6 + 0.4 * p, 0.9 - 0.4 * p, 0.3 + 0.4 * p, 1.0)

	GuiText(gui, mod_setting_group_x_offset, 0, text, 1, "", true)
	
    GuiColorSetForNextWidget(gui, 0.6, 0.6, 0.6, 1)

    local clicked,right_clicked = GuiButton(gui, im_id, mod_setting_group_x_offset + 24, -11, setting.ui_name)

    GuiColorSetForNextWidget(gui, 1, 1, 1, 1)

    if clicked then
		local value_old = value
		value_id = value_id + 1
		if value_id > #(setting.values) then
			value_id = 1
		end
		value = setting.values[value_id][1]
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), value, false  )
		mod_setting_handle_change_callback( mod_id, gui, in_main_menu, setting, value_old, value )
	end
	if right_clicked and setting.value_default then
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), setting.value_default, false  )
		mod_setting_handle_change_callback( mod_id, gui, in_main_menu, setting, value, setting.value_default )
	end

	mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
end

function mod_setting_image_ff(mod_id, gui, in_main_menu, im_id, setting)
	if setting.id == "heat_display_image" then
		local display = heat_displays[tonumber(ModSettingGetNextValue("foolish_flame.heat_display"))]

		GuiImage(gui, im_id, mod_setting_group_x_offset, 0, display.sprite, 1, 1, 0)
		--[[if not in_main_menu then
			GuiImage(gui, im_id, mod_setting_group_x_offset, -34, "mods/foolish_flame/files/ui_gfx/heat_display/generated/21.png", 1, 1, 0)
		end]]

		if not display.custom_logic then
			GuiImage(gui, im_id, mod_setting_group_x_offset + 24, -34, display.sprite_hot, 1, 1, 0)
			GuiImage(gui, im_id, mod_setting_group_x_offset + 24, -34, "mods/foolish_flame/files/ui_gfx/heat_display/full.png", 1, 1, 0)
		end
	else
		GuiImage(gui, im_id, mod_setting_group_x_offset, 0, setting.image_filename, 1, 1, 0)
	end

	if is_visible_string(setting.ui_description) then
		GuiTooltip(gui, setting.ui_description, "")
	end
end

function mod_setting_image_small(mod_id, gui, in_main_menu, im_id, setting)
	GuiImage(gui, im_id, mod_setting_group_x_offset, 0, setting.image_filename, 1, 0.5, 0)

	if is_visible_string(setting.ui_description) then
		GuiTooltip(gui, setting.ui_description, "")
	end
end

function mod_setting_change_callback(mod_id, gui, in_main_menu, setting, old_value, new_value)
	if setting.id == "heat_display" then
        setting.values = GetDisplays()
    end
end

local mod_id = "foolish_flame"
mod_settings_version = 1
mod_settings = {
	{
        id = "show_heat_gauge",
        ui_name = "Render heat gauge?",
        ui_description = "Should the heat gauge be hidden?",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME,
        ui_fn = mod_setting_bool_ff,
        value_type = "boolean",
    },
    {
        id = "heat_loss_mult",
        ui_name = "Heat loss multiplier",
        ui_description = "Passive heat decay should be multiplied by...",
        value_default = "1",
        values = {{"0.5", "x0.5"}, {"1", "x1"}, {"2", "x2"}, {"3", "x3"}},
        scope = MOD_SETTING_SCOPE_RUNTIME,
        ui_fn = mod_setting_enum_ff,
    },
	{
        id = "flare_wand_spawn_chance",
        ui_name = "Wand of Magic Fire chance",
        ui_description = "The chance of something being replaced...",
        value_default = "60",
        values = {{"0", "0%"}, {"20", "20%"}, {"40", "40%"}, {"60", "60%"}, {"80", "80%"}, {"100", "100%"}},
        scope = MOD_SETTING_SCOPE_RUNTIME,
        ui_fn = mod_setting_enum_ff,
    },
	--[[{
        id = "bounty_chance_mult", -- NYI
        ui_name = "Bounty enemy chance multiplier",
        ui_description = "Bounty enemy spawn chance should be multiplied by...",
        value_default = 1,
        values = { {0.5, "x0.5"}, {1, "x1"}, {2, "x2"}, {3, "x3"}},
        scope = MOD_SETTING_SCOPE_RUNTIME,
    },]]
	{
        id = "brimstone_heat",
        ui_name = "heat from Kiuaskivi per second",
        ui_description = "How much heat should kiuaskivi grant?",
        value_default = "4",
        values = {{"0", "0"}, {"2", "2"}, {"4", "4"}, {"8", "8"}, {"12", "12"}, {"16", "16"}},
        scope = MOD_SETTING_SCOPE_RUNTIME,
        ui_fn = mod_setting_enum_ff,
    },
}

function ModSettingsUpdate(init_scope)
	local old_version = mod_settings_get_version(mod_id)
	mod_settings_update(mod_id, mod_settings, init_scope)
end

function ModSettingsGuiCount()
	return mod_settings_gui_count(mod_id, mod_settings)
end

function ModSettingsGui(gui, in_main_menu)

    --[[GuiImage(gui, 1, 0, 0, "mods/foolish_flame/title.png", 1, 0.5)

    GuiColorSetForNextWidget(gui, 0.5, 0.5, 0.5, 1)

    GuiText(gui, 0, 0, "hello", 1, "", true)

    GuiColorSetForNextWidget(gui, 1, 1, 1, 1)]]

	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end