### [❮ Go back](../README.md) ❙ [Main Page](./_main.md)

# GSName: Examples
[#tn]: #./defs.md#timernew
[dt#tu]: #./defs/timer.md#timerupdate
[dt#tr]: #./defs/timer.md#timerrestart
[dt#ts]: #./defs/timer.md#timerstop
[dt#ts2]: #./defs/timer.md#timerstate

### Reappearing Bubble
A bubble shield that disappears when the player is hit and reappears 7 seconds later.
> ## Used Functions:
> * [`Timer:New()`][#tn]
> * [`<Timer>:Update()`][dt#tu]
> * [`<Timer>:Restart()`][dt#tr]
> * [`<Timer>:Stop()`][dt#ts]
> * [`<Timer>:State()`][dt#ts2]
```lua
--Create the timer.
--140 ticks = 7 seconds
local BubbleTimer = Timer:New(140, function()
  model.odd_shield.setEnabled(true)
end)

--Immediately stop the timer so the timer doesn't
--count down when the player first appears.
BubbleTimer:Stop()

local lastHealth = 20
function tick()
  local health = player.getHealth()
  if health < lastHealth and BubbleTimer:State() == "stopped" then
    model.odd_shield.setEnabled(false)
    --Start the timer again and allow it to count down.
    BubbleTimer:Restart()
  end
  lastHealth = health
  BubbleTimer:Update() --Count down the timer every tick.
end
```
***
### Using timers as counters
Timers can also be used as counters. This script will check if the player has been hit 6 times and enable a chestplate for a short while.
> ## Used Functions:
> * [`Timer:New()`][#tn]
> * [`<Timer>:Update()`][dt#tu]
> * [`<Timer>:Restart()`][dt#tr]
> * [`<Timer>:Stop()`][dt#ts]
```lua
local PlateTimer, HitCounter

--Create a new timer that activates when updated 6 times which
--enables the chestplate and starts another timer.
HitCounter = Timer:New(6, function()
  model.Body_repulseChest.setEnabled(true)
  PlateTimer:Restart()
end)

--Create a new timer that deactivates the chestplate after 3 seconds.
--This also restarts the hit counter.
PlateTimer = Timer:New(60, function()
  model.Body_repulseChest.setEnabled(false)
  HitCounter:Restart()
end)
--Immediately stop the timer so the timer doesn't
--count down when the player first appears.
PlateTimer:Stop()

local lastHealth = 20
function tick()
  local health = player.getHealth()
  if health < lastHealth then
    HitCounter:Update() --Count down one hit.
  end
  lastHealth = health
  PlateTimer:Update() --Count down the plate timer every tick.
end
```
***
