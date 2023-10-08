-- wield_gadgets/register.lua
-- Create registeration functions and tables

wield_gadgets.register_gadget = function(name,def)
    ---@diagnostic disable-next-line: undefined-field
    def = table.copy(def)

    def.groups = def.group or {}
    def.groups.gadgets = 1

    local function on_use(itemstack, placer)
        if wield_gadgets.change_gadget(placer,itemstack) then
            return ItemStack("")
        end
        return itemstack
    end

    def.on_place = def.on_place or on_use
    def.on_secondary_use = def.on_secondary_use or on_use

    def.stack_max = 1

    return minetest.register_craftitem(name,def)
end
