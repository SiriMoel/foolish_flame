dofile("data/scripts/lib/mod_settings.lua")
dofile("mods/foolish_flame/files/scripts/gauges.lua")
--dofile_once("mods/foolish_flame/files/scripts/keys.lua")

skeys = {
    [4] = "A",
    [5] = "B",
    [6] = "C",
    [7] = "D",
    [8] = "E",
    [9] = "F",
    [10] = "G",
    [11] = "H",
    [12] = "I",
    [13] = "J",
    [14] = "K",
    [15] = "L",
    [16] = "M",
    [17] = "N",
    [18] = "O",
    [19] = "P",
    [20] = "Q",
    [21] = "R",
    [22] = "S",
    [23] = "T",
    [24] = "U",
    [25] = "V",
    [26] = "W",
    [27] = "X",
    [28] = "Y",
    [29] = "Z",
    [30] = "1",
    [31] = "2",
    [32] = "3",
    [33] = "4",
    [34] = "5",
    [35] = "6",
    [36] = "7",
    [37] = "8",
    [38] = "9",
    [39] = "0",
    [40] = "Return",
    [42] = "Back",
    [43] = "Tab",
    [44] = "Space",
    [45] = "-",
    [46] = "=",
    [47] = "[",
    [48] = "]",
    [49] = [[\]],
    [51] = ";",
    [52] = "'",
    [53] = ",",
    [54] = "~",
    [55] = ".",
    [56] = "/",
    [57] = "CAPS",
    [73] = "Ins",
    [74] = "Home",
    [75] = "PgUp",
    [76] = "Del",
    [77] = "End",
    [78] = "PgDown",
    [79] = "Right",
    [80] = "Left",
    [81] = "Down",
    [82] = "Up",
    [83] = "Num",
    [84] = "KpDiv",
    [85] = "KpMult",
    [86] = "KpMinus",
    [87] = "KpPlus",
    [88] = "KpEnter",
    [89] = "Kp1",
    [90] = "Kp2",
    [91] = "Kp3",
    [92] = "Kp4",
    [93] = "Kp5",
    [94] = "Kp6",
    [95] = "Kp7",
    [96] = "Kp8",
    [97] = "Kp9",
    [98] = "Kp0",
    [99] = "Kp.",
    [103] = "KpEquals",
}

function mod_setting_bool_ff(mod_id, gui, in_main_menu, im_id, setting)
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	if type(value) ~= "boolean" then value = setting.value_default or false end

	local text = GameTextGet(value and "$ff_setting_on" or "$ff_setting_off")

	if in_main_menu then
		text = value and "ON!" or "Off"
	end

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

function mod_setting_image_small(mod_id, gui, in_main_menu, im_id, setting)
	GuiImage(gui, im_id, mod_setting_group_x_offset, 0, setting.image_filename, 1, 0.5, 0)

	if is_visible_string(setting.ui_description) then
		GuiTooltip(gui, setting.ui_description, "")
	end
end

function mod_setting_ff_key_magic(mod_id, gui, in_main_menu, im_id, setting)
	local value = ModSettingGetNextValue(mod_setting_get_id(mod_id, setting))
	if type(value) ~= "boolean" then value = setting.value_default or false end

    local key_now = ModSettingGetNextValue(setting.key_setting)

    local key_string = (skeys[key_now] ~= nil) and ("[" .. skeys[key_now] .. "]") or "???"

    local text = value and "!!! " or key_string

    if value then
        GuiColorSetForNextWidget(gui, 0.6, 0.7, 1.0, 1.0)
    else
        GuiColorSetForNextWidget(gui, 1.0, 0.9, 0.7, 1.0)
    end

	GuiText(gui, mod_setting_group_x_offset, 0, text, 1, "", true)

    GuiColorSetForNextWidget(gui, 0.6, 0.6, 0.6, 1.0)

    local text_offset = math.max(GuiGetTextDimensions(gui, text) + 4, 24)

    local clicked, right_clicked = GuiButton(gui, im_id, mod_setting_group_x_offset + text_offset, -11, setting.ui_name)

    GuiColorSetForNextWidget(gui, 1, 1, 1, 1)

    local set_key

    if value then
        for key = 4, 103 do
            if skeys[key] ~= nil and InputIsKeyDown(key) then
                set_key = key
                break
            end
        end
        if set_key ~= nil then
            ModSettingSetNextValue(setting.key_setting, set_key, false)
            ModSettingSetNextValue(mod_setting_get_id(mod_id, setting), false, false)
        end
    end

    if clicked then
		ModSettingSetNextValue(mod_setting_get_id(mod_id, setting), not value, false)
		mod_setting_handle_change_callback(mod_id, gui, in_main_menu, setting, value, not value)
	end
    if right_clicked then
        ModSettingSetNextValue(setting.key_setting, setting.key_setting_default, false)
        ModSettingSetNextValue(mod_setting_get_id(mod_id, setting), false, false)
        mod_setting_handle_change_callback(mod_id, gui, in_main_menu, setting, false, setting.value_default)
    end

	mod_setting_tooltip(mod_id, gui, in_main_menu, setting)
end

function mod_setting_change_callback(mod_id, gui, in_main_menu, setting, old_value, new_value)
	--[[if setting.id == "heat_display" then
        setting.values = GetDisplays()
    end]]
end

local mod_id = "foolish_flame"
mod_settings_version = 1
mod_settings = {
	{
		id = "heat_gauge",
		ui_name = "Heat gauge",
		value_default = 1,
		hidden = true,
	},
    {
        category_id = "gauge_settings",
        ui_name = "Heat Gauge settings",
        ui_description = "",
        foldable = true,
        _folded = true,
        settings = {
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
		        id = "gauge_previous_key",
		        ui_name = "FF Gui Key",
		        value_default = 47,
		        hidden = true,
                scope = MOD_SETTING_SCOPE_RUNTIME,
	        },
            {
                id = "set_gauge_previous",
                ui_name = "Previous heat gauge keybind",
                ui_description = "Click this and then press the desired key.",
                value_default = false,
                scope = MOD_SETTING_SCOPE_RUNTIME,
                ui_fn = mod_setting_ff_key_magic,
                key_setting = "foolish_flame.gauge_previous_key",
                key_setting_default = 47,
            },
            {
		        id = "gauge_next_key",
		        ui_name = "FF Gui Key",
		        value_default = 48,
		        hidden = true,
                scope = MOD_SETTING_SCOPE_RUNTIME,
	        },
            {
                id = "set_gauge_next",
                ui_name = "Next heat gauge keybind",
                ui_description = "Click this and then press the desired key.",
                value_default = false,
                scope = MOD_SETTING_SCOPE_RUNTIME,
                ui_fn = mod_setting_ff_key_magic,
                key_setting = "foolish_flame.gauge_next_key",
                key_setting_default = 48,
            },
        },
    },
	{
        id = "heat_damage_mult",
        ui_name = "Heat damage boost multiplier",
        ui_description = "The passive damage boost should be multiplied by...",
        value_default = "1",
        values = {{"0", "x0"}, {"0.3", "x0.3"}, {"0.5", "x0.5"}, {"0.7", "x0.7"}, {"1", "x1"}, {"1.5", "x1.5"}, {"2", "x2"}},
        scope = MOD_SETTING_SCOPE_RUNTIME,
        ui_fn = mod_setting_enum_ff,
    },
    {
        id = "heat_loss_mult",
        ui_name = "Heat loss multiplier",
        ui_description = "Passive heat decay should be multiplied by...",
        value_default = "1",
        values = {{"0.5", "x0.5"}, {"1", "x1"}, {"1.5", "x1.5"}, {"2", "x2"}},
        scope = MOD_SETTING_SCOPE_RUNTIME,
        ui_fn = mod_setting_enum_ff,
    },
	--[[{
        id = "brimstone_heat",
        ui_name = "Heat from Kiuaskivi per second",
        ui_description = "How much heat should kiuaskivi grant?",
        value_default = "4",
        values = {{"0", "0"}, {"2", "2"}, {"4", "4"}, {"8", "8"}, {"12", "12"}, {"16", "16"}},
        scope = MOD_SETTING_SCOPE_RUNTIME,
        ui_fn = mod_setting_enum_ff,
    },]]
	{
        id = "flare_wand_spawn_chance",
        ui_name = "Wand of Magic Fire chance",
        ui_description = "The chance of something being replaced...",
        value_default = "60",
        values = {{"0", "0%"}, {"20", "20%"}, {"40", "40%"}, {"60", "60%"}, {"80", "80%"}, {"100", "100%"}},
        scope = MOD_SETTING_SCOPE_RUNTIME,
        ui_fn = mod_setting_enum_ff,
    },
	{
        id = "bounty_chance_mult",
        ui_name = "Hell bounty chance multiplier",
        ui_description = "???",
        value_default = "1",
        values = {{"0", "x0"}, {"0.3", "x0.3"}, {"0.5", "x0.5"}, {"0.7", "x0.7"}, {"1", "x1"}, {"1.5", "x1.5"}, {"2", "x2"}},
        scope = MOD_SETTING_SCOPE_RUNTIME,
        ui_fn = mod_setting_enum_ff,
    },
	{
        id = "advanced_spell_descs",
        ui_name = "Advanced spell descriptions",
        ui_description = "Should spell descriptions have additional heat & magic fire information?\nMagic fire info is displayed as [temperature,duration,max temp.]",
        value_default = false,
        scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
        ui_fn = mod_setting_bool_ff,
        value_type = "boolean",
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
	mod_settings_gui(mod_id, mod_settings, gui, in_main_menu)
end