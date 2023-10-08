-- wield_gadgets/examples.lua
-- Example gadgets
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
-- luacheck: ignore

local S = minetest.get_translator("wield_gadgets")

if false then -- For update translation to work
    local _
    _ = S("Zoom")
    _ = S("Announce")
    _ = S("Never allowed")
end

wield_gadgets.register_gadget("wield_gadgets:example_zoom",{
    description = S("Example Gadget: @1",S("Zoom")),

    -- Return boolean, false if decline to wear
    -- Default to true
    _wg_allow_wield = function(player,stack) return true end,

    -- Being called when this gadget is weared
    -- Also called if a player wearing this gadget joined the game
    -- Default to nil
    _wg_on_activate = function(player,stack)
            player:set_properties({
            zoom_fov = 0.5
        })
    end,

    -- Being called when this gadget is unweared
    -- Also called if a player wearing this gadget leaved the game
    -- Default to nil
    _wg_on_deactivate = function(player,stack)
        player:set_properties({
            zoom_fov = 0
        })
    end,

    -- Being called when the zoom key is pressed while wearing this gadget
    -- Default to nil
    _wg_on_use = function(player,stack) return end,

    -- Being called when the zoom key is pressed while wearing this gadget
    -- Also called if a player wearing and using this gadget leaved the game
    -- Default to nil
    _wg_on_unuse = function(player,stack) return end,
})

wield_gadgets.register_gadget("wield_gadgets:example_announce",{
    description = S("Example Gadget: @1",S("Announce")),

    -- Return boolean, false if decline to wear
    -- Default to true
    _wg_allow_wield = function(player,stack) return true end,

    -- Being called when this gadget is weared
    -- Also called if a player wearing this gadget joined the game
    -- Default to nil
    _wg_on_activate = function(player,stack) return end,

    -- Being called when this gadget is unweared
    -- Also called if a player wearing this gadget leaved the game
    -- Default to nil
    _wg_on_deactivate = function(player,stack) return end,

    -- Being called when the zoom key is pressed while wearing this gadget
    -- Default to nil
    _wg_on_use = function(player,stack)
        minetest.chat_send_all(S("Hey, I am using gadget!"))
    end,

    -- Being called on every globalstep when the zoom key is hold
    _wg_while_use = function(player,stack) return end,

    -- Being called when the zoom key is pressed while wearing this gadget
    -- Also called if a player wearing and using this gadget leaved the game
    -- Default to nil
    _wg_on_unuse = function(player,stack)
        minetest.chat_send_all(S("Hey, I stopped using gadget!"))
    end,
})

wield_gadgets.register_gadget("wield_gadgets:example_never",{
    description = S("Example Gadget: @1",S("Never allowed")),

    -- Return boolean, false if decline to wear
    -- Default to true
    _wg_allow_wield = function(player,stack) return false end,

    -- Being called when this gadget is weared
    -- Also called if a player wearing this gadget joined the game
    -- Default to nil
    _wg_on_activate = function(player,stack) return end,

    -- Being called when this gadget is unweared
    -- Also called if a player wearing this gadget leaved the game
    -- Default to nil
    _wg_on_deactivate = function(player,stack) return end,

    -- Being called when the zoom key is pressed while wearing this gadget
    -- Default to nil
    _wg_on_use = function(player,stack) return end,

    -- Being called on every globalstep when the zoom key is hold
    _wg_while_use = function(player,stack) return end,

    -- Being called when the zoom key is pressed while wearing this gadget
    -- Also called if a player wearing and using this gadget leaved the game
    -- Default to nil
    _wg_on_unuse = function(player,stack) return end,
})

wield_gadgets.register_gadget("wield_gadgets:example_while",{
    description = S("Example Gadget: @1",S("Heal HP")),

    -- Return boolean, false if decline to wear
    -- Default to true
    _wg_allow_wield = function(player,stack) return true end,

    -- Being called when this gadget is weared
    -- Also called if a player wearing this gadget joined the game
    -- Default to nil
    _wg_on_activate = function(player,stack) return end,

    -- Being called when this gadget is unweared
    -- Also called if a player wearing this gadget leaved the game
    -- Default to nil
    _wg_on_deactivate = function(player,stack) return end,

    -- Being called when the zoom key is pressed while wearing this gadget
    -- Default to nil
    _wg_on_use = function(player,stack) return end,

    -- Being called on every globalstep when the zoom key is hold
    _wg_while_use = function(player,stack)
        player:set_hp(player:get_hp() + 1)
    end,

    -- Being called when the zoom key is pressed while wearing this gadget
    -- Also called if a player wearing and using this gadget leaved the game
    -- Default to nil
    _wg_on_unuse = function(player,stack) return end,
})