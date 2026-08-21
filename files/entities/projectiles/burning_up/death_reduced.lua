dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()

local root = EntityGetRootEntity(this)

local vel_x, vel_y = GameGetVelocityCompVelocity(root)

local amt = math.abs(vel_x + vel_y) * 0.01 * 0.2

if not EntityHasTag(root, "ff_nollad") then
    AddHeat(amt)
end