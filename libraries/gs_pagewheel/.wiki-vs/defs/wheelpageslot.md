### [❮ Go back](../../README.md) ❙ [Main Page](../_main.md) ❙ [Definitions](../defs.md)

# GSPagedWheel: WheelPageSlot Class
[@wpsd]: ../defs.md/#wheelpageslotdata

[dwp#wp]: ./wheelpage.md#wheelpage

[dwps@tf]: #togglefunction
[dwps@lf]: #listfunction
[dwps#wps]: #wheelpageslot
[dwps#wpsb]: #wheelpageslotbuild
[dwps#wpsst]: #wheelpageslotsettitle
[dwps#wpssi]: #wheelpageslotsetitem
[dwps#wpssf]: #wheelpageslotsetfunction
[dwps#wpssc]: #wheelpageslotsetcolor
[dwps#wpsshi]: #wheelpageslotsethoveritem
[dwps#wpsshc]: #wheelpageslotsethovercolor
[dwps#wpsmt]: #wheelpageslotmaketoggle
[dwps#wpsml]: #wheelpageslotmakelist
[dwps#wpsmgb]: #wheelpageslotmakegotobutton
[dwps#wpsmpb]: #wheelpageslotmakeprevbutton
[dwps#wpsmnb]: #wheelpageslotmakenextbutton
[dwps#wpsmpb2]: #wheelpageslotmakepingbutton
[dwps#wpstt]: #wheelpageslottotable
[dwps.wpsd]: #wheelpageslotdata
[dwps.wpssn]: #wheelpageslotslotnumber
[dwps.wpsts]: #wheelpageslottogglestate
[dwps.wpsso]: #wheelpageslotstateoff
[dwps.wpsso2]: #wheelpageslotstateon
[dwps.wpsl]: #wheelpageslotlist

# Types
### Contents:
> * [`ToggleFunction`][dwps@tf]
> * [`ListFunction`][dwps@lf]
***

## `ToggleFunction`
<pre>
<ct>func</ct>(<ca>state</ca>:&nbsp;<ct>boolean</ct>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`state`</ca>
> > ##### <ct>`boolean`</ct>
> > The new state of the toggle.
> ## Description:
> A function that runs when a toggle slot is activated.

&nbsp;
## `ListFunction`
<pre>
<ct>func</ct>(<ca>index</ca>:&nbsp;<ct>number</ct>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`index`</ca>
> > ##### <ct>`number`</ct>
> > The new state of the toggle.
> ## Description:
> A function that runs when a toggle slot is activated.

&nbsp;
# Library
### Contents:
> * [`<WheelPageSlot>`][dwps#wps]
>   * [`<WheelPageSlot>:Build()`][dwps#wpsb]
>   * [`<WheelPageSlot>:SetTitle()`][dwps#wpsst]
>   * [`<WheelPageSlot>:SetItem()`][dwps#wpssi]
>   * [`<WheelPageSlot>:SetFunction()`][dwps#wpssf]
>   * [`<WheelPageSlot>:SetColor()`][dwps#wpssc]
>   * [`<WheelPageSlot>:SetHoverItem()`][dwps#wpsshi]
>   * [`<WheelPageSlot>:SetHoverColor()`][dwps#wpsshc]
>   * [`<WheelPageSlot>:MakeToggle()`][dwps#wpsmt]
>   * [`<WheelPageSlot>:MakeList()`][dwps#wpsml]
>   * [`<WheelPageSlot>:MakeGotoButton()`][dwps#wpsmgb]
>   * [`<WheelPageSlot>:MakePrevButton()`][dwps#wpsmpb]
>   * [`<WheelPageSlot>:MakeNextButton()`][dwps#wpsmnb]
>   * [`<WheelPageSlot>:MakePingButton()`][dwps#wpsmpb2]
>   * [`<WheelPageSlot>:ToTable()`][dwps#wpstt]
>   * [`<WheelPageSlot>.data`][dwps.wpsd]
>   * [`<WheelPageSlot>.slotNumber`][dwps.wpssn]
>   * [`<WheelPageSlot>.toggleState`][dwps.wpsts]
>   * [`<WheelPageSlot>.stateOff`][dwps.wpsso]
>   * [`<WheelPageSlot>.stateOn`][dwps.wpsso2]
>   * [`<WheelPageSlot>.list`][dwps.wpsl]
***

## `<WheelPageSlot>`
### [<cc link>`WheelPageSlot`</cc>][dwps#wps]
> Library table description.

&nbsp;
## `<WheelPageSlot>:Build()`
<pre>
<cf><<cc>WheelPageSlot</cc>>:Build</cf>(<ca>data</ca>:&nbsp;<cc>WheelPageSlotData</cc>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`data`</ca>
> > ##### [<cc link>`WheelPageSlotData`</cc>][@wpsd]
> > The data to apply to the slot. Data is only replaced if it exists in the `data` given.  
> > I.e. A `data` with a missing function will not replace the function of the slot with nothing.
> ## Description:
> Applies data to the slot, replacing as needed.

&nbsp;
## `<WheelPageSlot>:SetTitle()`
<pre>
<cf><<cc>WheelPageSlot</cc>>:SetTitle</cf>(<ca>str</ca>:&nbsp;<ct>string</ct>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`str`</ca>
> > ##### <ct>`string`</ct>
> > The title to use.
> ## Description:
> Sets the title of this slot.

&nbsp;
## `<WheelPageSlot>:SetItem()`
<pre>
<cf><<cc>WheelPageSlot</cc>>:SetItem</cf>(<ca>item</ca>:&nbsp;<cc>ItemStack</cc>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`item`</ca>
> > ##### <cc>`ItemStack`</cc>
> > The item stack to use.
> ## Description:
> Sets the item icon to use for the slot.

&nbsp;
## `<WheelPageSlot>:SetFunction()`
<pre>
<cf><<cc>WheelPageSlot</cc>>:SetFunction</cf>(<ca>func</ca>:&nbsp;<ct>function</ct>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`func`</ca>
> > ##### <ct>`function`</ct>
> > The function to run.
> ## Description:
> Sets the function that runs when the slot is activated.

&nbsp;
## `<WheelPageSlot>:SetColor()`
<pre>
<cf><<cc>WheelPageSlot</cc>>:SetColor</cf>(<ca>col</ca>:&nbsp;<cc>VectorColor</cc>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`col`</ca>
> > ##### <cc>`VectorColor`</cc>
> > The color to use.
> ## Description:
> Sets the outline color of this slot.

&nbsp;
## `<WheelPageSlot>:SetHoverItem()`
<pre>
<cf><<cc>WheelPageSlot</cc>>:SetHoverItem</cf>(<ca>item</ca>:&nbsp;<cc>ItemStack</cc>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`item`</ca>
> > ##### <cc>`ItemStack`</cc>
> > The item stack to use while hovering.
> ## Description:
> Sets the item icon to use for this slot while it is hovered over.

&nbsp;
## `<WheelPageSlot>:SetHoverColor()`
<pre>
<cf><<cc>WheelPageSlot</cc>>:SetTitle</cf>(<ca>col</ca>:&nbsp;<cc>VectorColor</cc>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`col`</ca>
> > ##### <cc>`VectorColor`</cc>
> > The color to use while hovering.
> ## Description:
> Sets the hovered outline color of this slot.

&nbsp;
## `<WheelPageSlot>:MakeToggle()`
<pre>
<cf><<cc>WheelPageSlot</cc>>:MakeToggle</cf>(<ca>group</ca>:&nbsp;<ct>string</ct>, <ca>page</ca>:&nbsp;<ct>string</ct>|<ct>number</ct>, <ca>slotoff</ca>:&nbsp;<cc>SlotNumber</cc>, <ca>sloton</ca>:&nbsp;<cc>SlotNumber</cc>, <ca aopt>func</ca>:&nbsp;<ct>string</ct>|<cc>ToggleFunction</cc>, <ca aopt>startEnabled</ca>:&nbsp;<ct>boolean</ct>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`group`</ca>
> > ##### <ct>`string`</ct>
> > The group to look in for the toggle slots.
> ### <ca>`page`</ca>
> > ##### <ct>`string`</ct> **or** <ct>`number`</ct>
> > The page to look in for the toggle slots.
> ### <ca>`slotoff`</ca>
> > ##### <cc>`SlotNumber`</cc>
> > The slot to use for the off state.
> ### <ca>`sloton`</ca>
> > ##### <cc>`SlotNumber`</cc>
> > The slot to use for the on state.
> ### <ca opt>`func`</ca>
> > ##### <ct>`string`</ct> **or** [<cc link>`ToggleFunction`</cc>][dwps@tf]
> > The function to run when the slot is toggled. The new state of the toggle slot is passed into the function.  
> > If given a string, it will run the ping with the name of the given string.
> ## Description:
> Creates a slot that toggles between two different states by combining two different slots together.

&nbsp;
## `<WheelPageSlot>:MakeList()`
<pre>
<cf><<cc>WheelPageSlot</cc>>:MakeList</cf>(<ca>group</ca>:&nbsp;<ct>string</ct>, <ca>slots</ca>:&nbsp;<ct>number</ct>,<ca aopt>func</ca>:&nbsp;<ct>string</ct>|<cc>ListFunction</cc>, <ca aopt>startIndex</ca>:&nbsp;<ct>number</ct>, <ca aopt>dontError</ca>:&nbsp;<ct>boolean</ct>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`group`</ca>
> > ##### <ct>`string`</ct>
> > The group to look in for the list slots.
> ### <ca>`slots`</ca>
> > ##### <ct>`number`</ct>
> > The amount of slots to pull out of the group.  
> > Slots are pulled out by searching for numbered pages, starting at `1`, and pulling out the slots in order until this number of slots is reached.
> >
> > If this is set to `-1`, as many slots as possible are pulled.
> ### <ca opt>`func`</ca>
> > ##### <ct>`string`</ct> **or** [<cc link>`ListFunction`</cc>][dwps@lf]
> > The function to run when the slot is cycled. The new index of the list slot is passed into the function.  
> > If given a string, it will run the ping with the name of the given string.
> ### <ca opt>`startIndex`</ca>
> > ##### <ct>`number`</ct>
> > The index the list slot should start on when created.
> ### <ca opt>`dontError`</ca>
> > ##### <ct>`boolean`</ct>
> > By default, this function will throw an error if not enough slots are found to fill the list. If this is set, the function will instead silently ignore the error and shrink the list down to fit the new amount found.
> ## Description:
> Creates a list that you can scroll through by taking a group of slots.  
> The slots are taken in order by searching through numbered pages and then taking the slots of the found pages.
>
> The `Function` data of the found slots are ignored.

&nbsp;
## `<WheelPageSlot>:MakeGotoButton()`
<pre>
<cf><<cc>WheelPageSlot</cc>>:MakeGotoButton</cf>(<ca aopt>group</ca>:&nbsp;<ct>string</ct>, <ca aopt>page</ca>:&nbsp;<ct>string</ct>|<ct>number</ct>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca opt>`group`</ca>
> > ##### <ct>`string`</ct>
> > The group to go to.  
> > If unset, the group will not change. This can be used to go to a different page in the same group.
> ### <ca opt>`page`</ca>
> > ##### <ct>`string`</ct> **or** <ct>`number`</ct>
> > The page to go to.  
> > If unset, the page id will not change. This can be used to go to the same page id in a different group.
> ## Description:
> Makes a button that goes to a different page.

&nbsp;
## `<WheelPageSlot>:MakePrevButton()`
<pre>
<cf><<cc>WheelPageSlot</cc>>:MakePrevButton</cf>()
  ► <ct>void</ct>
</pre>
> ## Description:
> Makes a button that goes to the previous numbered page in the current group.
>
> If the current page is the first page, it will wrap around to the last page.  
> If the current page is not a numbered page, the button will throw an error.

&nbsp;
## `<WheelPageSlot>:MakeNextButton()`
<pre>
<cf><<cc>WheelPageSlot</cc>>:MakeNextButton</cf>()
  ► <ct>void</ct>
</pre>
> ## Description:
> Makes a button that goes to the next numbered page in the current group.
>
> If the current page is the last page, it will wrap around to the first page.  
> If the current page is not a numbered page, the button will throw an error.

&nbsp;
## `<WheelPageSlot>:MakePingButton()`
<pre>
<cf><<cc>WheelPageSlot</cc>>:MakePingButton</cf>(<ca>name</ca>:&nbsp;<ct>string</ct>, <ca aopt>value</ca>:&nbsp;<ct>any</ct>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`name`</ca>
> > ##### <ct>`string`</ct>
> > The name of the ping function.
> ### <ca opt>`value`</ca>
> > ##### <ct>`any`</ct>
> > The value to send through the ping.
> ## Description:
> Makes a button that runs a ping value. Can optionally send a static value through that ping.

&nbsp;
## `<WheelPageSlot>:ToTable()`
<pre>
<cf><<cc>WheelPageSlot</cc>>:ToTable</cf>()
  ► <cc>WheelPageSlotData</cc>
</pre>
> ## Returns:
> ### [<cc link>`WheelPageSlotData`</cc>][@wpsd]
> > The data in the WheelPageSlot.
> ## Description:
> Returns a copy of the data that makes up the WheelPageSlot. This data can be used to create a clone of this slot.

&nbsp;
## `<WheelPageSlot>.data`
### [<cc link>`WheelPageSlotData`</cc>][@wpsd]
> ## Description:
> The generic data that makes up this slot.

&nbsp;
## `<WheelPageSlot>.slotNumber`
### <cc>`SlotNumber`</cc>
> ## Description:
> The number of this slot in its containing [`WheelPage`][dwp#wp].

&nbsp;
## `<WheelPageSlot>.toggleState`
### <ct>`boolean`</ct>
> ## Description:
> The current state of the toggle slot.

&nbsp;
## `<WheelPageSlot>.stateOff`
### [<cc link>`WheelPageSlotData`</cc>][@wpsd]
> ## Description:
> The stored data for the off state of the toggle slot or selection slot.

&nbsp;
## `<WheelPageSlot>.stateOn`
### [<cc link>`WheelPageSlotData`</cc>][@wpsd]
> ## Description:
> The stored data for the on state of the toggle slot or selection slot.

&nbsp;
## `<WheelPageSlot>.list`
### [<cc array link>`WheelPageSlotData`</cc>][@wpsd]
> ## Description:
> The stored data for each of the items of the list slot.
