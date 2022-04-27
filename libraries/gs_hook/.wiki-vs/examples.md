### [❮ Go back](../README.md) ❙ [Main Page](./_main.md)

# GSHook: Examples
[#ha]: #hookadd
[#hr]: #hookrun

### A hook that simply runs functions
This script determines when you have lost health and then runs the `onDamage` hook, passing the new current health and how much health was lost.  
This example spawns particles based on how much health was lost and prints your health stats to the in-game chat.
> ## Used Functions:
> * [`hook.add()`][#ha]
> * [`hook.run()`][#hr]
```lua
hook.add("onDamage", "bleed", function(_, healthLost)
  local pos = player.getPos()
  for i=1,healthLost*2 do
    particle.addParticle("block", pos + vectors.of{
      math.random() - 0.5,
      math.random() * 2,
      math.random() - 0.5,
      (math.random() - 0.5) * 0.5,
      math.random() * 0.25,
      (math.random() - 0.5) * 0.5
    }, "minecraft:redstone_block")
  end
end)

hook.add("onDamage", "logHealth", function(currentHealth, healthLost)
  print(
    ("You had %d health.\nYou lost %d health.\nYou now have %d health")
      :format(currentHealth + healthLost, healthLost, currentHealth)
  )
end)


local lastHealth = 20
function tick()
  local health = player.getHealth()
  if health < lastHealth then
    hook.run("onDamage", health, lastHealth - health)
  end
  lastHealth = health
end
```
***
### A hook that determines the state of something else
This script determines when the nameplate should show up or not.  
This example determines if you are wearing a leather hat or are sneaking in a large fern.
> ## Used Functions:
> * [`hook.add()`][#ha]
> * [`hook.run()`][#hr]
```lua
hook.add("shouldShowNametag", "leatherHat", function()
  if player.getEquipmentItem(6).getType() == "minecraft:leather_helmet" then
    return false
  end
  -- Do not return anything if not wearing a leather hat
  -- so that other functions can still test.
end)

hook.add("shouldShowNametag", "hidingInBush", function()
  local pos = player.getPos() + vectors.of{0, 1, 0}
  local isInFern = world.getBlockState(pos).name == "minecraft:large_fern"
  if isInFern and player.isSneaky() then
    return false
  end
  -- Do not return anything if not sneaking in a large fern
  -- so that other functions can still test.
end)


function tick()
  --Expanded to show what is happening better.
  -- This can easily be done on one line with
  -- `nameplate.ENTITY.setEnabled(hook.run("shouldShowNametag") ~= false)`

  --`~= false` allows a hook with no functions to still succeed.
  if hook.run("shouldShowNametag") ~= false then 
    nameplate.ENTITY.setEnabled(true)
  else
    nameplate.ENTITY.setEnabled(false)
  end
end
```
***
