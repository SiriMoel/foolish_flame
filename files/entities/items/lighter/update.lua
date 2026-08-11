local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

local comp_state = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "lighter_state")

if comp_state ~= nil then
    local state = ComponentGetValue2(comp_state, "value_bool")

    local sprite = "mods/foolish_flame/files/entities/items/lighter/sprite.png"
    local sprite_in_hand = "mods/foolish_flame/files/entities/items/lighter/sprite_in_hand.png"
    if state then
        sprite = "mods/foolish_flame/files/entities/items/lighter/sprite_open.png"
        sprite_in_hand = "mods/foolish_flame/files/entities/items/lighter/sprite_open_in_hand.png"
    end
    local comp_item = EntityGetFirstComponentIncludingDisabled(this, "ItemComponent")
    ComponentSetValue2(comp_item, "ui_sprite", sprite)
    local comp_sprite_hand = EntityGetFirstComponentIncludingDisabled(this, "SpriteComponent", "sprite_hand")
    ComponentSetValue2(comp_sprite_hand, "image_file", sprite_in_hand)
    local comp_sprite_world = EntityGetFirstComponentIncludingDisabled(this, "SpriteComponent", "sprite_world")
    ComponentSetValue2(comp_sprite_world, "image_file", sprite_in_hand)
    EntityRefreshSprite(this, comp_sprite_hand)
    EntityRefreshSprite(this, comp_sprite_world)

    EntitySetComponentsWithTagEnabled(this, "ff_lighter", state)
end