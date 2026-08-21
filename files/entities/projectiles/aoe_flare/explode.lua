local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

--[[local parent = EntityGetRootEntity(this)
GamePrint(EntityGetName(parent))
local comp = EntityGetFirstComponentIncludingDisabled(this, "ProjectileComponent")
if comp ~= nil then
    local shooter = ComponentGetValue2(comp, "mEntityThatShot")
    if shooter == 0 then shooter = "no" end
    if EntityHasTag(shooter, "projectile_player") then GamePrint("hi") end
end]]

local targets = EntityGetInRadiusWithTag(x, y, 46, "homing_target")

if #targets > 0 then
    for i = 1, #targets do
        local target = targets[i]
        local c = EntityLoad("mods/foolish_flame/files/entities/projectiles/aoe_flare/hit_entity.xml", x, y)
        EntityAddChild(target, c)
    end
end

EntityKill(this)