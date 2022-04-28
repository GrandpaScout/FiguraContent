# GSHook
##### Identifier: `LIB_GSHOOK`
Adds Garry's Mod-style hooks to Figura.

```yaml
## SOURCE
VERSION:  ​0.1.0​
FILESIZE: ​4.03KB​
CHARS:    ​4023​
LINES:    ​94​

## COMPRESSED
VERSION:  ​0.1.0​
FILESIZE: ​1.63KB​
CHARS:    ​1522​
LINES:    ​21​

## LINE
VERSION:  ​0.1.0​
FILESIZE: ​1.55KB​
CHARS:    ​1441​
LINES:    ​2​
```

## Use
Allows adding "hooks" that other functions can watch or run.  
Functions that watch a hook will run when the hook is run.  
Functions that run a hook will also run all watching functions.

This allows you to run multiple functions from one point in your code.

As an example, you can run multiple functions every time you put on armor with a hook.
```lua
-- Create a seperate function...
local function showDiamondArmor(armor_type)
  model.armor.diamond.setEnabled(armor_type == "diamond")
end

-- Then bind it with `hook.add`
hook.add("wearArmor", "wearDiamond", showDiamondArmor)

-- ...Or create the function directly in the hook
hook.add("wearArmor", "sayHiToTheClass", function()
  print("Hi!")
end)

local lastType
function tick()
  -- Get the item in the chestplate slot
  local armorType = player.getEquipmentSlot(5).getType()
  -- Make sure it is a chestplate and extract the type.
  armorType = armorType:match("^minecraft:(.-)_chestplate$")

  -- Check if the last known type and this current type are different.
  if armorType ~= lastType then
    -- Run the "wearArmor" hook with `hook.run`
    -- The armor's type is passed as the first parameter.
    hook.run("wearArmor", armorType)
    lastType = armorType
  end
end
```

### [***Learn More***](./.wiki/_main.md)
### [***Learn More ( VSCode )***](./.wiki-vs/_main.md)
