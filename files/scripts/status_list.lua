dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local to_insert = {
    {
		id="MAGIC_FIRE",
		ui_name="magic fire nyi",
		ui_description="nyi nyi nyi",
		ui_icon="mods/foolish_flame/files/ui_gfx/status_indicators/magic_fire.png",
		--protects_from_fire=true,
		effect_entity="mods/foolish_flame/files/entities/misc/status_magic_fire/effect.xml",
	},
}

for i,v in ipairs(to_insert) do
    v.id = "FF_" .. v.id
    table.insert(status_effects, v)
end