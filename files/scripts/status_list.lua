--dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local to_insert = {
    {
		id="FF_MAGIC_FIRE",
		ui_name="$status_ff_magic_fire",
		ui_description="$statusdesc_ff_magic_fire",
		ui_icon="mods/foolish_flame/files/ui_gfx/status_indicators/magic_fire.png",
		--protects_from_fire=true,
		effect_entity="mods/foolish_flame/files/entities/misc/effect_magic_fire/effect.xml",
	},
}

local len = #status_effects
for i=1,#to_insert do
    status_effects[len+i]=to_insert[i]
end