-- the append is commented in init.lua

local a = {
	{
		id="REDUCE_HEAT_GAIN",
		ui_name="status_ff_reduce_heat_gain",
		ui_description="$statusdesc_ff_reduce_heat_gain",
		ui_icon="mods/foolish_flame/files/ui_gfx/status_indicators/reduce_heat_gain.png",
		effect_entity="mods/foolish_flame/files/entities/misc/effect_reduce_heat_gain.xml",
	},
}

for i,v in ipairs(a) do
    v.id = "FF_" .. v.id
    table.insert(status_effects, v)
end