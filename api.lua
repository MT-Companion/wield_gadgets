-- wield_gadgets/api.lua
-- APIs

wield_gadgets.log = function(lvl,msg)
    return minetest.log(lvl, "[wield_gadgets] " .. msg)
end

wield_gadgets.log_wear = function(player,stack)
    local name = player:get_player_name()
    if stack:is_empty() then
        return minetest.log("action",string.format(
            "Player %s unweared gadgets.",
            name
        ))
    end
    local gadget_name = stack:get_name()
    return minetest.log("action",string.format(
        "Player %s weared gadget %s.",
        name, gadget_name
    ))
end

wield_gadgets.log_unwear = function(player,stack)
    local name = player:get_player_name()
    if stack:is_empty() then
        return minetest.log("action",string.format(
            "Player %s unweared gadgets.",
            name
        ))
    end
    local gadget_name = stack:get_name()
    return minetest.log("action",string.format(
        "Player %s unweared gadget %s.",
        name, gadget_name
    ))
end

wield_gadgets.log_use = function(player,stack)
    local name = player:get_player_name()
    if stack:is_empty() then
        return
    end
    local gadget_name = stack:get_name()
    return minetest.log("action",string.format(
        "Player %s used gadget %s.",
        name, gadget_name
    ))
end

wield_gadgets.log_unuse = function(player,stack)
    local name = player:get_player_name()
    if stack:is_empty() then
        return
    end
    local gadget_name = stack:get_name()
    return minetest.log("action",string.format(
        "Player %s unused gadget %s.",
        name, gadget_name
    ))
end

wield_gadgets.change_gadget = function(player,item)
    local inv = player:get_inventory()
    local curr_gadget = inv:get_stack("gadget",1)
    local next_def = item:get_definition()
    if item and not item:is_empty() then
        if next_def._wg_allow_wield then
            if not next_def._wg_allow_wield(player,item) then
                return false
            end
        end
    end
    if not curr_gadget:is_empty() then
        if not inv:room_for_item("main",curr_gadget) then
            return false
        end
        local curr_def = curr_gadget:get_definition()
        if curr_def._wg_on_deactivate then
            curr_def._wg_on_deactivate(player,curr_gadget)
        end
        wield_gadgets.log_unwear(player,curr_gadget)
        inv:set_stack("gadget",1,ItemStack(""))
        inv:add_item("main",curr_gadget)
    end
    if item and not item:is_empty() then
        inv:set_stack("gadget",1,item)
        if next_def._wg_on_activate then
            next_def._wg_on_activate(player,item)
        end
        wield_gadgets.log_wear(player,item)
    end
    return true
end