local this = GetUpdatedEntityID()

local x, y = EntityGetTransform(this)

local comp_state = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "lighter_state")
local comp_frame = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "state_frame")

if comp_state ~= nil and comp_frame ~= nil then
    if InputIsMouseButtonDown(2) then
        local frame_last = ComponentGetValue2(comp_frame, "value_int")
        local frame = GameGetFrameNum()
        if frame > frame_last + 12 then
            local state = ComponentGetValue2(comp_state, "value_bool")
            state = not state
            ComponentSetValue2(comp_state, "value_bool", state)
            ComponentSetValue2(comp_frame, "value_int", frame)
            GamePlaySound("data/audio/Desktop/animals.bank", "animals/shotgun_cock", x, y)
            GamePlaySound("data/audio/Desktop/materials.bank", "collision/lantern/joint_break", x, y)
        end
    end
end