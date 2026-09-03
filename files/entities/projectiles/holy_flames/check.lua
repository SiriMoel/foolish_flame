local this = GetUpdatedEntityID()
local root = EntityGetRootEntity(this)
local c = EntityGetAllChildren(root, "ff_holy_flames") or {}
local max = 20
if #c > max then
    for i=max+1,#c do
        local v = c[i]
        if v == this then
            EntityKill(this)
        end
    end
end