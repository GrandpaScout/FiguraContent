### [❮ Go back](../README.md) ❙ [Main Page](./_main.md)

# GSPageWheel: Definitions
[@wpg]: #wheelpagegroup
[@wpsd]: #wheelpageslotdata
[#pw]: #pagewheel
[#pwn]: #pagewheelnew
[#pwg]: #pagewheelget
[#pws]: #pagewheelselect
[#pwu]: #pagewheelupdate

[dwp#wp]: ./defs/wheelpage.md#wheelpage

> ### Pages:
> * [**`WheelPage` Class**](./defs/wheelpage.md)
> * [**`WheelPageSlot` Class**](./defs/wheelpageslot.md)

# Types:
### Contents:
> * [`WheelPageGroup`][@wpg]
> * [`WheelPageSlotData`][@wpsd]
***

## `WheelPageGroup`
<pre>
<cv>{</cv> [<ca>page</ca>:&nbsp;<ct>string</ct>|<ct>number</ct>]:&nbsp;<cc>WheelPage</cc> <cv>}</cv>
</pre>
> ## Description:
> A table containing a variable amount of [`WheelPage`][dwp#wp] objects indexed by their page id.

## `WheelPageSlotData`
<pre>
<cv>{</cv>
  <ca aopt>Title</ca>:&nbsp;<ct>string</ct>,
  <ca aopt>Item</ca>:&nbsp;<cc>ItemStack</cc>,
  <ca aopt>Color</ca>:&nbsp;<cc>VectorColor</cc>,
  <ca aopt>Function</ca>:&nbsp;<ct>function</ct>,
  <ca aopt>HoverItem</ca>:&nbsp;<cc>ItemStack</cc>,
  <ca aopt>HoverColor</ca>:&nbsp;<cc>VectorColor</cc>
<cv>}</cv>
</pre>
> ## Description:
> Contains the basic data that a [`WheelPage`][dwp#wp] needs to work.
>
> All fields are optional. This allows the merging of WheelPages later.

&nbsp;
# Library
### Contents:
> * [`PageWheel`][#pw]
>   * [`PageWheel.New()`][#pwn]
>   * [`PageWheel.Get()`][#pwg]
>   * [`PageWheel.Select()`][#pws]
>   * [`PageWheel.Update()`][#pwu]
***

## `PageWheel`
> ##### <ct>`table`</ct>
> Contains the entire PageWheel library.

&nbsp;
## `PageWheel.New()`
<pre>
<cf>PageWheel.New</cf>(<ca>group</ca>:&nbsp;<ct>string</ct>, <ca>page</ca>:&nbsp;<ct>string</ct>|<ct>number</ct>, <ca aopt>data</ca>:&nbsp;<cc>WheelPageSlotData</cc>[])
  ► <cc>WheelPage</cc>
</pre>
> ## Parameters:
> ### <ca>`group`</ca>
> > ##### <ct>`string`</ct>
> > The group name for this Wheel Page.
> ### <ca>`page`</ca>
> > ##### <ct>`string`</ct> **or** <ct>`number`</ct>
> > The page id for this Wheel Page.
> ### <ca opt>`data`</ca>
> > ##### [<cc array link>`WheelPageSlotData`</cc>][@wpsd]
> > The data to load the Wheel Page with when it is created.
> >
> > This is an array of up to 8 [`WheelPageSlotData`][@wpsd] objects.
> ## Returns:
> ### [<cc link>`WheelPage`</cc>][dwp#wp]
> > The resulting WheelPage, for ease of later modification.
> ## Description:
> Creates a new WheelPage object in the given group name and page id.
>
> Optionally allows adding data for the page to start out with.

&nbsp;
## `PageWheel.Get()`
<pre>
<cf>PageWheel.Get</cf>(<ca>group</ca>:&nbsp;<ct>string</ct>, <ca aopt>page</ca>:&nbsp;<ct>string</ct>|<ct>number</ct>)
  ► <cc>WheelPageGroup</cc>|<cc>WheelPage</cc>
</pre>
> ## Parameters:
> ### <ca>`group`</ca>
> > ##### <ct>`string`</ct>
> > The group name to get.
> ### <ca opt>`page`</ca>
> > ##### <ct>`string`</ct> **or** <ct>`number`</ct>
> > If this is included, get only the page with this id instead of the entire group.
> ## Returns:
> ### [<cc link>`WheelPageGroup`</cc>][@wpg] **or** [<cc link>`WheelPage`</cc>][dwp#wp]
> > The WheelPage or WheelPage group that was found. If no group or page was found, returns `nil` instead.

&nbsp;
## `PageWheel.Select()`
<pre>
<cf>PageWheel.Select</cf>(<ca aopt>group</ca>:&nbsp;<ct>string</ct>, <ca aopt>page</ca>:&nbsp;<ct>string</ct>|<ct>number</ct>)
  ► <ct>ct</ct>
</pre>
> ## Parameters:
> ### <ca opt>`group`</ca>
> > ##### <ct>`string`</ct>
> > The group to select.  
> > If this is `nil`, the current group is selected.
> ### <ca opt>`page`</ca>
> > ##### <ct>`string`</ct> **or** <ct>`number`</ct>
> > The page to select.  
> > If this is `nil`, the current page id is selected.
> ## Description:
> Selects the given WheelPage and makes it the active page on the Action Wheel.  
> Leaving one of the parameters blank will make it not change, allowing quick switching of page ids without having to recall the current group name.

&nbsp;
## `PageWheel.Update()`
<pre>
<cf>PageWheel.Update</cf>(<ca aopt>slot</ca>:&nbsp;<ct>number</ct>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca opt>`slot`</ca>
> > ##### <ct>`number`</ct>
> > If this is set, only update *this* slot in the Action Wheel.
> ## Description:
> Updates the entire Action Wheel or a slot in it. Useful if a WheelPage updates while it is being used.
