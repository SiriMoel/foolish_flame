local this = GetUpdatedEntityID()

local root = EntityGetRootEntity(this)

local x, y = EntityGetTransform(root)

local comp_state = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "lighter_state")

if comp_state ~= nil then
    local state = ComponentGetValue2(comp_state, "value_bool")
    if state then
        GetGameEffectLoadTo(root, "ON_FIRE", false)
        LoadGameEffectEntityTo(root, "mods/foolish_flame/files/entities/misc/effect_reduce_heat_gain.xml")
    end
end