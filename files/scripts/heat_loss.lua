dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local player = GetUpdatedEntityID()

local heat = GetHeat(player)

if heat > 0 then
    local amt = 1

    -- this is a normal way to do this
    if heat > 75 then
        amt = amt + 0.5
        if heat > 100 then
            amt = amt + 0.5
            if heat > 125 then
                amt = amt + 1
                if heat > 150 then
                    amt = amt + 1
                    if heat > 175 then
                        amt = amt + 2
                        if heat > 200 then
                            amt = amt + 1 + math.ceil((heat - 200) / 5)
                            if heat > 300 then
                                amt = amt * 1.6
                                if amt > 600 then
                                    for i=1,math.floor(amt / 600) do
                                        amt = amt * 1.5
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    if EntityHasTag(player, "ff_slow_heat_loss") then
        amt = amt * 0.5
    end

    amt = amt / 2 -- ran 15 times per second, instead of 30

    RemoveHeat(amt, player)
end
