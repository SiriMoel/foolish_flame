dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

InflictMagicFire(root, 10, 12, 10)

EntityKill(this)