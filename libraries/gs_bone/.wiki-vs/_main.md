### [❮ Go back](../)

# GSBone: Wiki
[#bn]: ./defs.md#bonenew

[db#b]: ./defs/bone.md#bone
[db#bn]: ./defs/bone.md#bonenew

#### This wiki is updated to version `0.1.0`
> ### Pages:
> * [**Definitions**](./defs.md)
> * [**Examples**](./examples.md)

GSBone adds a bone system with layers. This allows multiple functions to edit the same bone without overwriting each other. It also allows bones to mimic other bones.

You can create a completely new bone with [<code link ulink><cf>Bone:New</cf>(<ca>part</ca>)</code>][#bn]. Bones created this way are normal bones that do not inherit any values. These bones can be modified by the script like normal.  
You can create an inheriting bone with [<code link ulink><cf><<cc>Bone</cc>>:New</cf>(<ca>part</ca>, <ca aopt>direct_parent</ca>)</code>][db#bn]. Bones created this way are inheriting bones that inherit values from the bone that created them. These bones cannot be modified by the script, but instead mimic the bone that created them.

[`Bone` Objects][db#b] have too many methods to list here, go to their definition page to learn more about them. They also get the functions of the part that they contain. (Minus a few specific ones.)
