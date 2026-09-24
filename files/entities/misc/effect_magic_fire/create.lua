local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

if not EntityHasTag(root, "player_unit") then
    local comps = EntityGetComponent(root, "LuaComponent", "ff_fire_death") or {}
    if #comps == 0 then
        EntityAddComponent2(root, "LuaComponent", {
            _tags="ff_fire_death",
            script_death="mods/foolish_flame/files/entities/misc/effect_magic_fire/death.lua"
        })
    end
end