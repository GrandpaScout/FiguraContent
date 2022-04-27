### [❮ Go back](../) ❙ [Main Page](./_main.md)

# GSBone: Examples
[#bn]: ./defs.md#bonenew
[#uab]: ./defs.md#updateallbones

[db#bn]: ./defs/bone.md#bonenew
[db#bsr]: ./defs/bone.md#bonesetrot
[db#bu]: ./defs/bone.md#boneupdate

### Two layers affecting the same Bone.
This script will make the model's head rotate from side to side while also shaking it.
> ## Uses:
> * [`Bone:New()`][#bn]
> * [`<Bone>:SetRot()`][db#bsr]
> * [`<Bone>:Update()`][db#bu]
```lua
local HeadBone = Bone:New(model.Head)

local time = 0
function tick()
  time = world.getTime()
  HeadBone:SetRot("Shake", {
    (math.random() - 0.5) * 5,
    (math.random() - 0.5) * 5,
    (math.random() - 0.5) * 3
  })
end

function render(delta)
  local dtime = time + delta
  HeadBone:SetRot("BackNForth", {math.sin(dtime) * 60})

  HeadBone:Update()
end
```
***
### A quick and dirty tail example
This script makes a quick and dirty tail animation using inheriting bones.
> ## Uses:
> * [`Bone:New()`][#bn]
> * [`UpdateAllBones()`][#uab]
> * [`<Bone>:New()`][db#bn]
> * [`<Bone>:SetRot()`][db#bsr]
```lua
local TailBase = Bone:New(model.Body.tail_base)
local TailBones = {
  TailBase,
  TailBase:New(model.Body.tail_base.tail_1, true),
  TailBase:New(model.Body.tail_base.tail_1.tail_2, true),
  TailBase:New(model.Body.tail_base.tail_1.tail_2.tail_3, true),
  TailBase:New(model.Body.tail_base.tail_1.tail_2.tail_3.tail_tip, true)
}

local time = 0
function tick()
  time = world.getTime()
end

function render(delta)
  local dtime = time + delta
  TailBase:SetRot("Anim", {0, math.sin(dtime) * 20})

  UpdateAllBones(TailBones)
end
```
***
