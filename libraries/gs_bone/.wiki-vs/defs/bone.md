### [❮ Go back](../../README.md) ❙ [Main Page](../_main.md) ❙ [Definitions](../defs.md)

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
### [<cc link>`Bone`</cc>][db#b]
> A Bone instance. This is the main object of this library.
>
> Bone objects also contain all of the functions of the part they contain.  
> (Except for `setPos`, `setRot`, `setScale`, and `setEnabled` which are replaced with functions that better suit Bones.)

&nbsp;
## `<Bone>:New()`
<pre>
<<cc>Bone</cc>><cf>:New</cf>(<ca>part</ca>:&nbsp;<cc>CustomModelPart</cc>, <ca aopt>direct_parent</ca>:&nbsp;<ct>boolean</ct>)
  ► <cc>Bone</cc>
</pre>
> ## Parameters:
> ### <ca>`part`</ca>
> > ##### <cc>`CustomModelPart`</cc>
> > The custom model part this bone controls.
> ### <ca opt>`direct_parent`</ca>
> > ##### <ct>`boolean`</ct>
> > Determines if the bone being inherited from is the direct parent of the given part. If it is, the new bone is updated in a different way to avoid position and scaling issues.
> ## Returns:
> ### [<cc link>`Bone`</cc>](#bone)
> > The bone that controls the selected custom model part.
> ## Description:
> Creates a new Bone object that controls a custom model part.
>
> This new bone object cannot be manipulated normally, it instead mimics the bone it inherits from.
>
> *Do not confuse this with [<code link ulink><cf>Bone:New</cf>(<ca>part</ca>)</code>][#bn]! That function creates a non-inheriting bone, this function creates an **inheriting** bone.*

&nbsp;
## `<Bone>:SetPos()`
<pre>
<cf><<cc>Bone</cc>>:SetPos</cf>(<ca>layer</ca>:&nbsp;<ct>string</ct>, <ca>pos</ca>:&nbsp;<cc>VectorPos</cc>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`layer`</ca>
> > ##### <ct>`string`</ct>
> > The layer to set the position on.  
> > If the layer does not yet exist, it will be created.
> ### <ca>`pos`</ca>
> > ##### <cc>`VectorPos`</cc>
> > The position to set on the selected layer.
> ## Description:
> Sets the position of a layer to the <cc>`VectorPos`</cc> given.  
> Each layer contains its own position which are all then combined when the bone is updated with [<code link ulink><cf><<cc>Bone</cc>>:Update</cf>()</code>][db#bu]

&nbsp;
## `<Bone>:SetRot()`
<pre>
<cf><<cc>Bone</cc>>:SetRot</cf>(<ca>layer</ca>:&nbsp;<ct>string</ct>, <ca>ang</ca>:&nbsp;<cc>VectorAng</cc>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`layer`</ca>
> > ##### <ct>`string`</ct>
> > The layer to set the rotation on.  
> > If the layer does not yet exist, it will be created.
> ### <ca>`ang`</ca>
> > ##### <cc>`VectorAng`</cc>
> > The rotation to set on the selected layer.
> ## Description:
> Sets the rotation of a layer to the <cc>`VectorAng`</cc> given.  
> Each layer contains its own rotation which are all then combined when the bone is updated with [<code link ulink><cf><<cc>Bone</cc>>:Update</cf>()</code>][db#bu]

&nbsp;
## `<Bone>:SetScale()`
<pre>
<cf><<cc>Bone</cc>>:SetScale</cf>(<ca>layer</ca>:&nbsp;<ct>string</ct>, <ca>scale</ca>:&nbsp;<cc>VectorPos</cc>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`layer`</ca>
> > ##### <ct>`string`</ct>
> > The layer to set the rotation on.  
> > If the layer does not yet exist, it will be created.
> ### <ca>`scale`</ca>
> > ##### <cc>`VectorPos`</cc>
> > The scale to set on the selected layer.
> ## Description:
> Sets the scale of a layer to the <cc>`VectorPos`</cc> given.  
> Each layer contains its own scale which are all then multiplied together when the bone is updated with [<code link ulink><cf><<cc>Bone</cc>>:Update</cf>()</code>][db#bu]

&nbsp;
## `<Bone>:SetEnabled()`
<pre>
<cf><<cc>Bone</cc>>:SetEnabled</cf>(<ca>state</ca>:&nbsp;<ct>boolean</ct>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`state`</ca>
> > ##### <ct>`boolean`</ct>
> > If the bone should be visible or not.
> ## Description:
> Sets the visibility of the bone.  
> Bones will refuse to update while they are not visible. This means that bones will need to be updated as soon as they are made visible if they have attempted to update while invisible.

&nbsp;
## `<Bone>:DelPos()`
<pre>
<cf><<cc>Bone</cc>>:DelPos</cf>(<ca>layer</ca>:&nbsp;<ct>string</ct>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`layer`</ca>
> > ##### <ct>`string`</ct>
> > The layer to remove.
> ## Description:
> Deletes the selected position layer.  
> Does nothing if the layer does not exist.

&nbsp;
## `<Bone>:DelRot()`
<pre>
<cf><<cc>Bone</cc>>:DelRot</cf>(<ca>layer</ca>:&nbsp;<ct>string</ct>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`layer`</ca>
> > ##### <ct>`string`</ct>
> > The layer to remove.
> ## Description:
> Deletes the selected rotation layer.  
> Does nothing if the layer does not exist.

&nbsp;
## `<Bone>:DelScale()`
<pre>
<cf><<cc>Bone</cc>>:DelScale</cf>(<ca>layer</ca>:&nbsp;<ct>string</ct>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`layer`</ca>
> > ##### <ct>`string`</ct>
> > The layer to remove.
> ## Description:
> Deletes the selected scale layer.  
> Does nothing if the layer does not exist.

&nbsp;
## `<Bone>:Update()`
<pre>
<cf><<cc>Bone</cc>>:Update</cf>()
  ► <ct>void</ct>
</pre>
> ## Description:
> Updates the bone with the new combined values of all layers on the bone.
>
> If the bone is currently disabled, the bone will *not* update. Keep this in mind and make sure to update the bone when it is re-enabled.
