dofile("data/scripts/lib/mod_settings.lua")
dofile("mods/foolish_flame/files/scripts/displays.lua")

function mod_setting_image_ff( mod_id, gui, in_main_menu, im_id, setting )
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

function mod_setting_change_callback( mod_id, gui, in_main_menu, setting, old_value, new_value  )
	if setting.id == "heat_display" then
        setting.values = GetDisplays()
    end
end

local mod_id = "foolish_flame"
mod_settings_version = 1
mod_settings = {
    --[[{
        id = "heat_display_image",
		image_filename = "mods/foolish_flame/files/ui_gfx/heat_display/flame.png",
        ui_fn = mod_setting_image_ff,
    },
    {
		id = "heat_display",
		ui_name = "Heat Display",
		ui_description = "Which heat display sprite should be used?",
		value_default = "1",
		values = GetDisplays() or {},
		scope = MOD_SETTING_SCOPE_RUNTIME,
		change_fn = mod_setting_change_callback,
	},]]
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