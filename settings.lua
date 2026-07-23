dofile_once("data/scripts/lib/mod_settings.lua")
dofile_once("mods/foolish_flame/files/scripts/displays.lua")

function mod_setting_bool_custom( mod_id, gui, in_main_menu, im_id, setting )
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	local text = setting.ui_name .. " - " .. GameTextGet( value and "$option_on" or "$option_off" )

	if GuiButton( gui, im_id, mod_setting_group_x_offset, 0, text ) then
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), not value, false )
	end

	mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
end

function mod_setting_change_callback( mod_id, gui, in_main_menu, setting, old_value, new_value  )
    if setting.id == "heat_display" then
        setting.values = GetDisplays()
    end
end

local mod_id = "foolish_flame"
mod_settings_version = 1
mod_settings = {
    {
        image_filename = "mods/foolish_flame/files/ui_gfx/gun_actions/bunsen.png",
        ui_fn = mod_setting_image,
    },
    {
		id = "heat_display",
		ui_name = "Heat Display",
		ui_description = "Which heat display sprite should be used?",
		value_default = "1",
		values = GetDisplays() or {},
		scope = MOD_SETTING_SCOPE_RUNTIME,
		change_fn = mod_setting_change_callback,
	},
}

function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id )
	mod_settings_update( mod_id, mod_settings, init_scope )
end

function ModSettingsGuiCount()
	return mod_settings_gui_count( mod_id, mod_settings )
end

function ModSettingsGui( gui, in_main_menu )
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end