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
### [<cc link>`Bone`</cc>][db#b]
> A default Bone with no target.  
> Its main use is to create new non-inheriting bones with [<code link ulink><cf>Bone:New</cf>(<ca>part</ca>)</code>][#bn]
>
> Do not confuse this with the Bone instance ([`<Bone>`][db#b] as an instance, [`Bone`][#b] as a type)

&nbsp;
## `Bone:New()`
<pre>
<cf>Bone:New</cf>(<ca>part</ca>:&nbsp;<cc>CustomModelPart</cc>)
  ► <cc>Bone</cc>
</pre>
> ## Parameters:
> ### <ca>`part`</ca>
> > ##### <cc>`CustomModelPart`</cc>
> > The custom model part this bone controls.
> ## Returns:
> ### [<cc link>`Bone`</cc>][db#b]
> > The bone that controls the selected custom model part.
> ## Description:
> Creates a new Bone object that controls a custom model part.  
> This bone's layers can be manipulated and then the bone can be updated to apply all layers at once.
>
> *Do not confuse this with [<code link ulink><cf><<cc>Bone</cc>>:New</cf>(<ca>part</ca>, <ca aopt>direct_parent</ca>)</code>][db#bn]! That function creates an inheriting bone, this function does **not**.*
***
## `UpdateAllBones()`
<pre>
<cf>UpdateAllBones</cf>(<ca aopt>of</ca>:&nbsp;<cc>Bone</cc>[])
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca opt>`of`</ca>
> > ##### [<cc link>`Bone[]`</cc>][db#b]
> > An optional array of bones that this function should be restricted to updating.  
> > If left blank, this function will update every bone that exists.
> ## Description:
> Updates either every bone that exists or only the selected bones. The common use of this function is to update every bone at the end of a `render` cycle.
