-- wield_gadgets/init.lua

local MP = minetest.get_modpath("wield_gadgets")
wield_gadgets = {}

for _,key in ipairs({"api","register","inventory","callbacks","formspec","examples"}) do
    dofile(MP .. "/" .. key .. ".lua")
end