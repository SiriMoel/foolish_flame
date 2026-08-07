local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

local targets = EntityGetInRadiusWithTag(x, y, 5, "card_action") or {}

if #targets > 0 then
    for i=1,#targets do
        local target = targets[i]
        if EntityGetRootEntity(target) == target then
            local comp_action = EntityGetFirstComponentIncludingDisabled(target, "ItemActionComponent")
            if comp_action ~= nil then
                local action_id = ComponentGetValue2(comp_action, "action_id")
                CreateItemActionEntity(action_id, x, y-6)
                GamePrint("Magic!")
                GameCreateSpriteForXFrames("data/particles/creepy.xml", x, y, true, 0, 0, 28)
                EntityKill(this)
                break
            end
        end
    end
end