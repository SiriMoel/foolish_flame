function GenerateGaugeSteps(id, path, template_path, template_width, template_height, empty_pixel_path)
    template_width = template_width or 20
    template_height = template_height or 34
    empty_pixel_path = empty_pixel_path or "mods/foolish_flame/files/ui_gfx/heat_display/empty_pixel.png"

    local template, template_w, template_h = ModImageMakeEditable(template_path, template_width, template_height)
    
    local empty, empty_w, empty_h = ModImageMakeEditable(empty_pixel_path, 1, 1)
    local empty_pixel = ModImageGetPixel(empty, 0, 0)

    local bounds = {}
    
    local bounds_y = {min = nil, max = nil}

    for y = 0, template_h - 1 do
        local bound_min = 0
        local bound_max = template_h - 1
        local bound_min_found = false
        local bound_max_found = false
        for x = 0, template_w - 1 do
            local pixel = ModImageGetPixel(template, x, y)
            if bounds_y.min == nil then
                if pixel ~= empty_pixel then
                    bounds_y.min = y - 1
                    bounds_y.max = y - 1
                end
            else
                if pixel ~= empty_pixel then
                    bounds_y.max = math.max(bounds_y.max, y + 1)
                end
            end
            if bound_min_found == false then
                if pixel ~= empty_pixel then
                    bound_min = x - 1
                    bound_min_found = true
                end
            elseif bound_max_found == false then
                if pixel == empty_pixel then
                    bound_max = x
                    bound_max_found = true
                end
            else
                break
            end
        end
        bounds[y] = {min = bound_min, max = bound_max}
    end

    local step_upto = 0

    for layer_y = bounds_y.max - 1, bounds_y.min + 1, -1 do
        local steps_this_layer = bounds[layer_y].max - bounds[layer_y].min - 1
        for step_x = bounds[layer_y].min + 1, bounds[layer_y].min + steps_this_layer do
            local image = ModImageMakeEditable(path .. "/" .. step_upto .. ".png", template_width, template_height)
            if layer_y < bounds_y.max - 1 then
                for p_y = bounds_y.max - 1, layer_y + 1, -1 do
                    for p_x = 0, template_width - 1 do
                        ModImageSetPixel(image, p_x, p_y, ModImageGetPixel(template, p_x, p_y))
                    end
                end
            end
            for x = bounds[layer_y].min + 1, step_x do
                ModImageSetPixel(image, x, layer_y, ModImageGetPixel(template, x, layer_y))
            end
            step_upto = step_upto + 1
        end
    end

    print("GAUGEMAKER - STEPS FOR \"" .. id .. "\" GAUGE: " .. step_upto - 1)
end