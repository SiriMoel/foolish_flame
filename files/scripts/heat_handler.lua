dofile_once("mods/foolish_flame/files/scripts/utils.lua")

local times_per_second = 5

local player = GetUpdatedEntityID()

local heat = GetHeat(player)

local amt_gain = 0
local amt_loss = 0

local frames = FramesSinceLastHeated(player)

local x, y = EntityGetTransform(player)


-- GAINING HEAT

local magic_fires = EntityGetInRadiusWithTag(x, y, 200, "ff_magic_fire_effect") or {}
if #magic_fires > 0 then
    for i=1,#magic_fires do
        local fire = magic_fires[i]
        local comp_temp = EntityGetFirstComponentIncludingDisabled(fire, "VariableStorageComponent", "fire_temp")
        if comp_temp ~= nil then
            local fx, fy = EntityGetTransform(fire)
            local dist = math.sqrt((x-fx)^2 + (y-fy)^2)
            local hit = 0
            if RaytraceSurfaces(fx, fy, x, y) then 
                hit = hit + 0.5
            elseif RaytraceSurfacesAndLiquiform(fx, fy, x, y) then -- why?
                hit = hit + 0.3
            end
            local temp = ComponentGetValue2(comp_temp, "value_int")
            if hit > 0 then
                hit = hit * (1 - (temp / 11))
            end
            amt_gain = amt_gain + (6 + temp * 2) * (1 - dist/200) * (1-hit)
        end
    end
end

local suns = EntityGetInRadiusWithTag(x, y, 400, "ff_sun") or {}
if #suns > 0 then
    for i=1,#suns do
        local sun = suns[i]
        local sun_x, sun_y = EntityGetTransform(sun)
        local dist = math.sqrt((x-sun_x)^2 + (y-sun_y)^2)
        amt_gain = amt_gain + 100 * (1 - dist/400)
    end
end

if heat <= 100 then
    local lavas = EntityGetInRadiusWithTag(x, y, 120, "ff_lava") or {}
    if #lavas > 0 then
        for i=1,#lavas do
            local lava = lavas[i]
            local fx, fy = EntityGetTransform(lava)
            local dist = math.sqrt((x-fx)^2 + (y-fy)^2)
            local hit = 0
            if RaytraceSurfaces(fx, fy, x, y) then 
                hit = hit + 0.5
            end
            amt_gain = amt_gain + 2 * (1 - dist/120) * (1-hit)
        end
    end

    local firemages = EntityGetInRadiusWithTag(x, y, 160, "firemage") or {}
    if #firemages > 0 then
        for i=1,#firemages do
            local firemage = firemages[i]
            local fx, fy = EntityGetTransform(firemage)
            local dist = math.sqrt((x-fx)^2 + (y-fy)^2)
            amt_gain = amt_gain + 3 * (1 - dist/160)
        end
    end
end

if heat <= 150 then
    local biome = BiomeMapGetName()
    if biome == "$biome_rainforest" then
        amt_gain = amt_gain + 4
    elseif biome == "$biome_dragoncave" then
        amt_gain = amt_gain + 6
    end

    local inv_items = GameGetAllInventoryItems(player) or {}
    if #inv_items > 0 then
        for i=1,#inv_items do
            local item = inv_items[i]
            local heater_comps = EntityGetComponent(item, "VariableStorageComponent", "ff_inventory_heater") or {}
            if #heater_comps > 0 then
                for ii=1,#heater_comps do
                    amt_gain = amt_gain + ComponentGetValue2(heater_comps[ii], "value_float")
                end
            end
        end
    end
end

amt_gain = amt_gain / times_per_second


-- LOSING HEAT

if heat > 0 then
    amt_loss = amt_loss + 2

    if frames > 30 then
        amt_loss = amt_loss + 23 * math.min((frames - 30) / 600, 1)
    end

    if heat > 300 then
        amt_loss = amt_loss + math.max((heat - 300) / 5, 2)
    else
        amt_loss = amt_loss + math.floor(heat / 100)
    end

    if EntityHasTag(player, "ff_slow_heat_loss") then
        amt_loss = amt_loss * 0.5
    end

    local mult = tonumber(GlobalsGetValue("ff_heat_loss_mult", "1")) or 1
    amt_loss = amt_loss * mult

    amt_loss = amt_loss / times_per_second
end


-- HEAT HANDLING

if amt_gain > 0 then
    AddHeat(amt_gain, player)
end
if amt_loss > 0 then
    RemoveHeat(amt_loss, player)
end

--[[local amt = amt_gain - amt_loss
if amt > 0 then
    AddHeat(amt, player)
else
    RemoveHeat(-amt, player)
end]]