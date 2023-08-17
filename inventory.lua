-- Register inventory and HUD, and handle inventory actions

minetest.register_on_joinplayer(function(player, last_login)
    local inv = player:get_inventory()
    inv:set_size("gadget",1)

    player:hud_add({
        hud_elem_type = "inventory",
        direction = 0,
        position = {x = 0, y = 1},
        offset = {x = 200, y = -80},
        alignment = {x = 0, y = 0},

        text = "gadget", -- The name of the inventory list to be displayed.
        number = 1, -- Number of items in the inventory to be displayed.
        item = 1, -- Position of item that is selected.
    })
end)

minetest.register_allow_player_inventory_action(function(player, action, inventory, inventory_info)
    local listname = inventory_info.listname
    if action == "take" then
        listname = nil
    elseif action == "move" then
        listname = inventory_info.to_list
    end
    if listname == "gadget" then
        local stack = inventory_info.stack
        if action == "move" then
            stack = inventory:get_stack(inventory_info.from_list,inventory_info.from_index)
        end
        local def = stack:get_definition()

        -- Only allow item in group gadgets
        if not (def.groups) or def.groups.gadgets ~= 1 then
            return 0
        end

        -- Check for custom allow wield function
        if def._wg_allow_wield then
            if not def._wg_allow_wield(player,stack) then
                return 0
            end
        end

        -- Stack number of gadget is always 1
        return 1
    end
end)

minetest.register_on_player_inventory_action(function(player, action, inventory, inventory_info)
    if action == "take" then
        local stack = inventory_info.stack
        local def = stack:get_definition()
        if def._wg_on_deactivate then
            def._wg_on_deactivate(player,stack)
        end
        wield_gadgets.log_unwear(player,stack)
    elseif action == "put" then
        local stack = inventory_info.stack
        local def = stack:get_definition()
        if def._wg_on_activate then
            def._wg_on_activate(player,stack)
        end
        wield_gadgets.log_wear(player,stack)
    elseif action == "move" then
        local inv = player:get_inventory()
        if inventory_info.from_list == "gadget" then
            local stack = inv:get_stack(inventory_info.to_list,inventory_info.to_index)
            local def = stack:get_definition()
            if def._wg_on_deactivate then
                def._wg_on_deactivate(player,stack)
            end
            wield_gadgets.log_unwear(player,stack)
        elseif inventory_info.to_list == "gadget" then
            local stack = inv:get_stack(inventory_info.to_list,inventory_info.to_index)
            local def = stack:get_definition()
            if def._wg_on_activate then
                def._wg_on_activate(player,stack)
            end
            wield_gadgets.log_wear(player,stack)
        end
    end
end)