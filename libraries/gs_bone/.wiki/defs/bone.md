### [❮ Go back](../../) ❙ [Main Page](../_main.md) ❙ [Definitions](../defs.md)

# GSBone: Bone Class
[#bn]: ../defs.md#bonenew

[db#b]: #bone
[db#bn]: #bonenew
[db#bsp]: #bonesetpos
[db#bsr]: #bonesetrot
[db#bss]: #bonesetscale
[db#bse]: #bonesetenabled
[db#bdp]: #bonedelpos
[db#bdr]: #bonedelrot
[db#bds]: #bonedelscale
[db#bu]: #boneupdate

### Contents:
> * [`<Bone>`][db#b]
>   * [`<Bone>:New()`][db#bn]
>   * [`<Bone>:SetPos()`][db#bsp]
>   * [`<Bone>:SetRot()`][db#bsr]
>   * [`<Bone>:SetScale()`][db#bss]
>   * [`<Bone>:SetEnabled()`][db#bse]
>   * [`<Bone>:DelPos()`][db#bdp]
>   * [`<Bone>:DelRot()`][db#bdr]
>   * [`<Bone>:DelScale()`][db#bds]
>   * [`<Bone>:Update()`][db#bu]
***

## `<Bone>`
> ##### [`Bone`][db#b]
> A Bone object. This is the main object of this library.
>
> Bone objects also contain all of the functions of the part they contain.  
> (Except for `setPos`, `setRot`, `setScale`, and `setEnabled` which are replaced with functions that better suit Bone objects.)

&nbsp;
## `<Bone>:New()`
```ts
<Bone>:New(part: CustomModelPart, direct_parent?: boolean)
  ► Bone
```
> ## Parameters:
> ### `part`
> > ##### `CustomModelPart`
> > The custom model part this bone controls.
> ### *`optional`* `direct_parent`
> > ##### `boolean`
> > Determines if the bone being inherited from is the direct parent of the given part. If it is, the new bone is updated in a different way to avoid position and scaling issues.
> ## Returns:
> ### [`Bone`][db#b]
> > The bone that controls the selected custom model part.
> ## Description:
> Creates a new Bone object that controls a custom model part.
>
> This new bone object cannot be manipulated normally, it instead mimics the bone it inherits from.
>
> *Do not confuse this with [`Bone:New(part)`][#bn]! That function creates a non-inheriting bone, this function creates an **inheriting** bone.*

&nbsp;
## `<Bone>:SetPos()`
```ts
<Bone>:SetPos(layer: string, pos: VectorPos)
  ► void
```
> ## Parameters:
> ### `layer`
> > ##### `string`
> > The layer to set the position on.  
> > If the layer does not yet exist, it will be created.
> ### `pos`
> > ##### `VectorPos`
> > The position to set on the selected layer.
> ## Description:
> Sets the position of a layer to the `VectorPos` given.  
> Each layer contains its own position which are all then combined when the bone is updated with [`<Bone>:Update()`][db#bu].

&nbsp;
## `<Bone>:SetRot()`
```ts
<Bone>:SetRot(layer: string, ang: VectorAng)
  ► void
```
> ## Parameters:
> ### `layer`
> > ##### `string`
> > The layer to set the rotation on.  
> > If the layer does not yet exist, it will be created.
> ### `ang`
> > ##### `VectorAng`
> > The rotation to set on the selected layer.
> ## Description:
> Sets the rotation of a layer to the `VectorAng` given.  
> Each layer contains its own rotation which are all then combined when the bone is updated with [`<Bone>:Update()`][db#bu].

&nbsp;
## `<Bone>:SetScale()`
```ts
<Bone>:SetScale(layer: string, scale: VectorPos)
  ► void
```
> ## Parameters:
> ### `layer`
> > ##### `string`
> > The layer to set the rotation on.  
> > If the layer does not yet exist, it will be created.
> ### `scale`
> > ##### `VectorPos`
> > The scale to set on the selected layer.
> ## Description:
> Sets the scale of a layer to the `VectorPos` given.  
> Each layer contains its own scale which are all then multiplied together when the bone is updated with [`<Bone>:Update()`][db#bu].

&nbsp;
## `<Bone>:SetEnabled()`
```ts
<Bone>:SetEnabled(state: boolean)
  ► void
```
> ## Parameters:
> ### `state`
> > ##### `boolean`
> > If the bone should be visible or not.
> ## Description:
> Sets the visibility of the bone.  
> Bones will refuse to update while they are not visible. This means that bones will need to be updated as soon as they are made visible if they have attempted to update while invisible.

&nbsp;
## `<Bone>:DelPos()`
```ts
<Bone>:DelPos(layer: string)
  ► void
```
> ## Parameters:
> ### `layer`
> > ##### `string`
> > The layer to remove.
> ## Description:
> Deletes the selected position layer.  
> Does nothing if the layer does not exist.

&nbsp;
## `<Bone>:DelRot()`
```ts
<Bone>:DelRot(layer: string)
  ► void
```
> ## Parameters:
> ### `layer`
> > ##### `string`
> > The layer to remove.
> ## Description:
> Deletes the selected rotation layer.  
> Does nothing if the layer does not exist.

&nbsp;
## `<Bone>:DelScale()`
```ts
<Bone>:DelScale(layer: string)
  ► void
```
> ## Parameters:
> ### `layer`
> > ##### `string`
> > The layer to remove.
> ## Description:
> Deletes the selected scale layer.  
> Does nothing if the layer does not exist.

&nbsp;
## `<Bone>:Update()`
```ts
<Bone>:Update()
  ► void
```
> ## Description:
> Updates the bone with the new combined values of all layers on the bone.
>
> If the bone is currently disabled, the bone will *not* update. Keep this in mind and make sure to update the bone when it is re-enabled.
