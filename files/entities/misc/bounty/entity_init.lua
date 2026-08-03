local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

SetRandomSeed(x, y)

local threshold = math.ceil(9 + (y - 23000)/1700)

if (y > 20000) and (Random(1, 100) <= threshold) then
    local comp = EntityGetFirstComponentIncludingDisabled(this, "DamageModelComponent")
    if comp ~= nil then
        local hp = ComponentGetValue2(comp, "hp")
        local max_hp = ComponentGetValue2(comp, "max_hp")
        ComponentSetValue2(comp, "hp", hp * 2)
        ComponentSetValue2(comp, "max_hp", max_hp * 2)
    end
    local shield_temp = math.min(math.floor(5 + (y - 20000)/3000), 9)
    EntityAddComponent2(this, "VariableStorageComponent", {
        _tags="ff_bounty_shield_temp",
		name="ff_bounty_shield_temp",
		value_int=shield_temp
    })
    EntityAddComponent2(this, "VariableStorageComponent", {
        _tags="ff_bounty_frame_damaged_last",
		name="ff_bounty_frame_damaged_last",
		value_int=0
    })
    EntityAddComponent2(this, "LuaComponent", {
        script_damage_about_to_be_received="mods/foolish_flame/files/entities/misc/bounty/damage_handler.lua",
		script_damage_received="mods/foolish_flame/files/entities/misc/bounty/damage_handler.lua",
    })
    EntityAddComponent2(this, "LuaComponent", {
        script_death="mods/foolish_flame/files/entities/misc/bounty/death.lua",
    })
    EntityAddComponent2(this, "LuaComponent", {
        script_source_file="mods/foolish_flame/files/entities/misc/bounty/display.lua",
        execute_every_n_frame=1
    })
end