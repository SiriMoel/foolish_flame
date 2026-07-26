dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local card = GetUpdatedEntityID()

local c = EntityGetAllChildren(card, "willow_wisp")

local target_x, target_y

if #c > 0 then
    local wisp = c[1]

    local root = EntityGetRootEntity(card)

    local root_x, root_y = EntityGetTransform(root)

    target_x, target_y = root_x, root_y - 12

    if root == card then

        target_y = target_y - 10

        EntitySetComponentsWithTagEnabled(wisp, "ff_wisp", true)

    elseif EntityHasTag(root, "player_unit") then

        local comp_inv2 = EntityGetFirstComponentIncludingDisabled(root, "Inventory2Component")

        local parent = EntityGetParent(card)

        if comp_inv2 ~= nil then
            local active_item = ComponentGetValue2(comp_inv2, "mActiveItem")
            if active_item == parent then
                EntitySetComponentsWithTagEnabled(wisp, "ff_wisp", true)
            else
                EntitySetComponentsWithTagEnabled(wisp, "ff_wisp", false)
            end
        end
    end

    local lerp_amount = 0.975
    local bob_h = 6
    local bob_w = 20
    local bob_speed_y = 0.065
    local bob_speed_x = 0.01421

    local pos_x, pos_y = EntityGetTransform(wisp)

    if pos_x == 0 and pos_y == 0 then
    	pos_x, pos_y = root_x, root_y
    end

    local time = GameGetFrameNum()
    local r = ProceduralRandomf(wisp, 0, -1, 1)

    time = time + r * 10000
    bob_speed_y = bob_speed_y + (r * bob_speed_y * 0.1)
    bob_speed_x = bob_speed_x + (r * bob_speed_x * 0.1)
    lerp_amount = lerp_amount - (r * lerp_amount * 0.01)

    target_y = target_y + math.sin(time * bob_speed_y) * bob_h
    target_x = target_x + math.sin(time * bob_speed_x) * bob_w

    local dist_x = pos_x - target_x

    pos_x,pos_y = vec_lerp(pos_x, pos_y, target_x, target_y, lerp_amount)
    EntitySetTransform(wisp, pos_x, pos_y, 0, 1, 1)
end