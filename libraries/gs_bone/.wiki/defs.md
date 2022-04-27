### [❮ Go back](../) ❙ [Main Page](./_main.md)

# GSBone: Definitions
[#b]: #bone
[#bn]: #bonenew
[#uab]: #updateallbones

[db#b]: ./defs/bone.md#bone
[db#bn]: ./defs/bone.md#bonenew

> ### Pages:
> * [**`Bone` Class**](./defs/bone.md)

# Library
### Contents:
> * [`Bone`][#b]
>   * [`Bone:New()`][#bn]
> * [`UpdateAllBones()`][#uab]
***

## `Bone`
### [`Bone`][db#b]
> A default Bone with no target.  
> Its main use is to create new non-inheriting bones with [`Bone:New(part)`][#bn]
>
> Do not confuse this with the Bone instance ([`<Bone>`][db#b] as an instance, [`Bone`][#b] as a type)

&nbsp;
## `Bone:New()`
```ts
Bone:New(part: CustomModelPart)
  ► Bone
```
> ## Parameters:
> ### `part`
> > ##### `CustomModelPart`
> > The custom model part this bone controls.
> ## Returns:
> ### [`Bone`][db#b]
> > The bone that controls the selected custom model part.
> ## Description:
> Creates a new Bone object that controls a custom model part.  
> This bone's layers can be manipulated and then the bone can be updated to apply all layers at once.
>
> *Do not confuse this with [`<Bone>:New(part, direct_parent?)`][db#bn]! That function creates an inheriting bone, this function does **not**.*
***
## `UpdateAllBones()`
```ts
UpdateAllBones(of?: Bone[])
  ► void
```
> ## Parameters:
> ### *`optional`* `of`
> > ##### [`Bone[]`][db#b]
> > An optional array of bones that this function should be restricted to updating.  
> > If left blank, this function will update every bone that exists.
> ## Description:
> Updates either every bone that exists or only the selected bones. The common use of this function is to update every bone at the end of a `render` cycle.
