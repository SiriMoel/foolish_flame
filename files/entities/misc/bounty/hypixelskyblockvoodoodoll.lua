dofile_once("data/scripts/lib/utilities.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)
local x, y = EntityGetTransform(root)

local t = EntityGetInRadiusWithTag(x, y, 120, "player_unit") or {}

if #t > 0 then
    local target = t[1]
	local tx, ty = EntityGetTransform(target)

	if not RaytraceSurfacesAndLiquiform(x, y, tx, ty) then
		local count = 4 + math.min(math.floor((y - 20000)/3000), 12)

		for i=1,count do

			local angle = i/count * math.pi * 2

        	local dist = 70

        	local spawn_x = tx - math.cos(angle) * dist
        	local spawn_y = ty - 4 - math.sin(angle) * dist

			local vel_mult = 12
			
			local vel_x = math.cos(angle) * dist * vel_mult
			local vel_y = math.sin(angle) * dist * vel_mult

			local proj = shoot_projectile(root, "mods/foolish_flame/files/entities/misc/bounty/hypixelskyblockvoodoodoll_projectile.xml", spawn_x, spawn_y, vel_x, vel_y)
		end
	end
end