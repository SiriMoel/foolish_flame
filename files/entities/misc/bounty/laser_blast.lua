dofile_once("data/scripts/lib/utilities.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)
local x, y = EntityGetTransform(root)

local t = EntityGetInRadiusWithTag(x, y, 220, "player_unit") or {}

if #t > 0 then
    local count = 18 + math.min(math.floor((y - 20000)/5000), 8)
    for i=1,count do	
	    local arc = ((2 * math.pi) / count) * i
	    local vel_x = math.cos(arc) * 250
	    local vel_y = 0 - math.sin(arc) * 250
	
	    local proj = shoot_projectile(root, "mods/foolish_flame/files/entities/misc/bounty/laser_blast_proj.xml", x, y, vel_x, vel_y)
    end
end