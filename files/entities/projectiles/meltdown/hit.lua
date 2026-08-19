dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

InflictMagicFire(root, 1, 540, 9)

EntityKill(this)