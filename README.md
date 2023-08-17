# Gadgets, always ready for use

This mod is an API for registering gadgets that can be used without switching to that hotbar slot. With this API, gadgets can be used by pressing the zoom key.

## (As an end user) How to use

Most gadgets supports fast-equiping by rightclicking while holding it. It will be moved into the `gadget` slot of your inventory.

After equipping one, pressing the zoom key (default: `Z`) will allow you to use a gadget. Refer to the manual of the gadget to know how it works.

## (As an developer) Registering new gadgets

The registeration of gadgets is done via the function `wield_gadgets.register_gadget`. The syntax of this function is the same as `minetest.register_craftitem`, but the definition table is a bit different:

```lua
{
    -- Almosty all normal fields can be used unless otherwise specified

    -- This two callbacks can be registered normally.
    -- However, if they are not set, their functions are set to equip this gadget.
    on_place = wield_gadgets_on_use,
    on_secondary_use = wield_gadgets_on_use,

    -- Return boolean, false if decline to wear
    -- Default to true
    _wg_allow_wield = function(player,item) return true end,

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

    -- Being called when the zoom key is pressed while wearing this gadget
    -- Also called if a player wearing and using this gadget leaved the game
    -- Default to nil
    _wg_on_unuse = function(player,stack) return end,

    -- Groups can be freely set
    -- However, the `gadgets` group is always set to 1 to indicate this is a gadget.
    -- The code will deal with this special group.
    groups = {
        gadgets = 1,
        -- And all other custom groups...
    }

    -- The max stack amount must be 1.
    -- The code will set this for you.
    stack_max = 1,
}
```
