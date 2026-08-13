dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()

local root = EntityGetRootEntity(this)

if EntityHasTag(root, "player_unit") and RemoveHeat2(8) then
    LoadGameEffectEntityTo(root, "mods/foolish_flame/files/entities/misc/effect_reduce_heat_gain.xml")
    --GetGameEffectLoadTo(root, "FF_REDUCE_HEAT_GAIN", false)
    local comps = EntityGetComponent(root, "DamageModelComponent") or {}
	if #comps > 0 then
		for _,comp in ipairs(comps) do
			local hp = ComponentGetValue2(comp, "hp")
			hp = hp + 0.2 + hp * 0.03
			ComponentSetValue2(comp, "hp", hp)
		end
	end
end