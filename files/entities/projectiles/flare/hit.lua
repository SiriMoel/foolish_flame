local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)

GamePrint("hit entity with magic fire: " .. EntityGetName(root))

-- play sound?

local comp_vel = EntityGetFirstComponentIncludingDisabled(root, "VelocityComponent")
if comp_vel ~= nil then
    local vel_x, vel_y = GameGetVelocityCompVelocity(root)

    vel_x = 0 -- placeholder // scorch shot behaviour?
    vel_y = -40 -- scale with fire temp

    ComponentSetValue2(comp_vel, "mVelocity", vel_x, vel_y)
end

EntityKill(this)