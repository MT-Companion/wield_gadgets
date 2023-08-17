-- Formspec allowing players to wear gadgets
-- WIP! TODO: Make a nicer formspec and/or intergrate it into existing inventory formspecs

local S = minetest.get_translator("wield_gadgets")

local formspec = "" ..
    "size[8.01,6.18]" .. 
    "list[current_player;gadget;0.1,0.11;1.0,1.0;0]" ..
    "list[current_player;main;0.1,2.28;8.0,1.0;0]" ..
    "list[current_player;main;0.1,3.36;8.0,1.0;8]" ..
    "list[current_player;main;0.1,4.44;8.0,1.0;16]" ..
    "list[current_player;main;0.1,5.53;8.0,1.0;24]"
local formname = "wield_gadgets:default_form"

wield_gadgets.show_formspec = function(name)
    minetest.show_formspec(name,formname,formspec)
end

minetest.register_chatcommand("wg_form",{
    description = S("Manage wield gadgets"),
    func = function(name,param)
        wield_gadgets.show_formspec(name)
        return true
    end
})



