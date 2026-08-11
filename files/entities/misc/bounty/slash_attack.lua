dofile_once("data/scripts/lib/utilities.lua")

local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)
local x, y = EntityGetTransform(root)

local t = EntityGetInRadiusWithTag(x, y, 222, "player_unit") or {}

if #t > 0 then
    local target = t[1]
	local tx, ty = EntityGetTransform(target)

	if not RaytraceSurfacesAndLiquiform(x, y, tx, ty) then
		local count = 1 + math.min(math.floor((y - 20000)/18000), 2)

		for i=1,count do
			SetRandomSeed(x + tx + i, y - ty)

			local dist_x = x - tx
			local dist_y = y - ty

			local arc = math.atan(dist_y / dist_x) + Random(-12, 12) * 0.0003 * math.pi * 2

			local vel_x = dist_y / math.tan(arc) * -330
			local vel_y = math.tan(arc) * dist_x * -330

			local proj = shoot_projectile(root, "mods/foolish_flame/files/entities/misc/bounty/slash.xml", x, y, vel_x, vel_y)
		end
	end
end