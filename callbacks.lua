-- Handle the use of the hotkey
-- It is now hardcoded into zoom key.

local pressed = {}

minetest.register_globalstep(function(dtime)
    for _,player in ipairs(minetest.get_connected_players()) do
        local name = player:get_player_name()
        local controls = player:get_player_control()
        if controls.zoom ~= (pressed[name] or false) then
            pressed[name] = (controls.zoom or nil)
            local inv = player:get_inventory()
            local gadget = inv:get_stack("gadget",1)
            if not gadget:is_empty() then
                local def = gadget:get_definition()
                if controls.zoom then
                    if def._wg_on_use then
                        def._wg_on_use(player,gadget)
                    end
                    wield_gadgets.log_use(player,gadget)
                else
                    if def._wg_on_unuse then
                        def._wg_on_unuse(player,gadget)
                    end
                    wield_gadgets.log_unuse(player,gadget)
                end
            end
        end
    end
end)

-- Fake a wear action for players who just joined
minetest.register_on_joinplayer(function(player, last_login)
    local inv = player:get_inventory()
    local gadget = inv:get_stack("gadget",1)
    if not gadget:is_empty() then
        local def = gadget:get_definition()
        if def._wg_on_activate then
            def._wg_on_activate(player,gadget)
        end
        wield_gadgets.log_wear(player,gadget)
    end
end)

-- Fake a unuse and unwear action for players leaving
minetest.register_on_leaveplayer(function(player, timed_out)
    local inv = player:get_inventory()
    local gadget = inv:get_stack("gadget",1)
    local name = player:get_player_name()
    if not gadget:is_empty() then
        local def = gadget:get_definition()
        if pressed[name] then
            pressed[name] = nil
            if def._wg_on_unuse then
                def._wg_on_unuse(player,gadget)
            end
            wield_gadgets.log_unuse(player,gadget)
        end
        if def._wg_on_deactivate then
            def._wg_on_deactivate(player,gadget)
        end
        wield_gadgets.log_unwear(player,gadget)
    end
end)