-- wield_gadgets/callbacks.lua
-- Handle keybindings
--[[
    Copyright (C) 2023  1F616EMO

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
    USA
]]

local key = "zoom"
local pressed = {}

-- When the player starts to use the gadget
keybinding.register_on_press(key, function(player)
    local name = player:get_player_name()
    local inv = player:get_inventory()
    local gadget = inv:get_stack("gadget",1)
    pressed[name] = true
    if not gadget:is_empty() then
        local def = gadget:get_definition()
        if def._wg_on_use then
            def._wg_on_use(player, gadget)
        end
        wield_gadgets.log_use(player, gadget)
    end
end)

-- While the player is holding the key
keybinding.register_hold_step(key, function(player)
    local inv = player:get_inventory()
    local gadget = inv:get_stack("gadget",1)
    if not gadget:is_empty() then
        local def = gadget:get_definition()
        if def._wg_while_use then
            def._wg_while_use(player, gadget)
        end
    end
end)

-- When the player stops to use the gadget
keybinding.register_on_release(key, function(player)
    local inv = player:get_inventory()
    local gadget = inv:get_stack("gadget",1)
    if not gadget:is_empty() then
        local def = gadget:get_definition()
        if def._wg_on_unuse then
            def._wg_on_unuse(player, gadget)
        end
        wield_gadgets.log_unuse(player, gadget)
    end
end)

-- Fake a wear action for players who just joined
minetest.register_on_joinplayer(function(player)
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
minetest.register_on_leaveplayer(function(player)
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