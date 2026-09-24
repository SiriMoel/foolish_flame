dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

if not EntityHasTag(root, "player_unit") then
    InflictMagicFire(root, 1, 480, 8)
    local comps = EntityGetComponent(root, "LuaComponent", "ff_reclaimer") or {}
    if #comps == 0 then
        EntityAddComponent2(root, "LuaComponent", {
            _tags="ff_reclaimer",
            script_death="mods/foolish_flame/files/entities/projectiles/reclaimer_flare/death.lua"
        })
    end
end

AddHeat(2)

EntityKill(this)