### [❮ Go back](../../README.md) ❙ [Main Page](../_main.md) ❙ [Definitions](../defs.md)

# GSPageWheel: WheelPage Class
[@wpsd]: ../defs.md#wheelpageslotdata

[dwp@sf]: #selectionfunction
[dwp#wp]: #wheelpage
[dwp#wpms]: #wheelpagemakeselection
[dwp#wptt]: #wheelpagetotable
[dwp.wpls]: #wheelpageleftsize
[dwp.wprs]: #wheelpagerightsize
[dwp.wpss]: #wheelpageselectedslot
[dwp.wp#]: #wheelpagenumber

[dwps#wps]: ./wheelpageslot.md

# Types
### Contents:
> * [`SelectionFunction`][dwp@sf]
***

## `SelectionFunction`
<pre>
<ct>func</ct>(<ca>slotid</ca>:&nbsp;<cc>SlotNumber</cc>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`slotid`</ca>
> > ##### <cc>`SlotNumber`</cc>
> > The number of the slot that activated this function.
> ## Description:
> A function that runs when a selection slot is selected.

&nbsp;
# Library
### Contents:
> * [`<WheelPage>`][dwp#wp]
>   * [`<WheelPage>:MakeSelection()`][dwp#wpms]
>   * [`<WheelPage>:ToTable()`][dwp#wptt]
>   * [`<WheelPage>[number]`][dwp.wp#]
>   * [`<WheelPage>.leftSize`][dwp.wpls]
>   * [`<WheelPage>.rightSize`][dwp.wprs]
>   * [`<WheelPage>.selectedSlot`][dwp.wpss]
***

## `<WheelPage>`
### [<cc link>`WheelPage`</cc>][dwp#wp]
> A WheelPage instance. This is a container object for [`WheelPageSlot`][dwps#wps] object of the PageWheel system.

&nbsp;
## `<WheelPage>:MakeSelection()`
<pre>
<cf><<cc>WheelPage</cc>>:MakeSelection</cf>(<cc>group</cc>:&nbsp;<ct>string</ct>, <cc>pageoff</cc>:&nbsp;<ct>string</ct>|<ct>number</ct>, <cc>pageon</cc>:&nbsp;<ct>string</ct>|<ct>number</ct>, <ca aopt>func</ca>:&nbsp;<ct>string</ct>|<cc>SelectionFunction</cc>, <ca aopt>startSelect</ca>:&nbsp;<cc>SlotNumber</cc>, <ca aopt>ignoredSlots</ca>:&nbsp;<cc>SlotNumber</cc>[])
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`group`</ca>
> > ##### <ct>`string`</ct>
> > The group to look in for the selection pages.
> ### <ca>`pageoff`</ca>
> > ##### <ct>`string`</ct> **or** <ct>`number`</ct>
> > The page used for the off state of the selection slots.
> ### <ca>`pageon`</ca>
> > ##### <ct>`string`</ct> **or** <ct>`number`</ct>
> > The page used for the on state of the selection slots.
> ### <ca opt>`func`</ca>
> > ##### <ct>`string`</ct> **or** [<cc link>`SelectionFunction`</cc>][dwp@sf]
> > The function to run when a slot is selected. The number of the activating slot is passed into the function.  
> > If given a string, it will run the ping with the name of the given string.  
> > This function will not run if an already selected slot is clicked again.
> ### <ca opt>`startSelect`</ca>
> > ##### <cc>`SlotNumber`</cc>
> > The slot to start on when this selection is created. This is automatically clamped.
> > If this is left blank, the first available slot will be made the starting slot.
> ### <ca opt>`ignoredSlots`</ca>
> > ##### <cc array>`SlotNumber`</cc>
> > An array of slot numbers to ignore while making the selection. Useful for embedding extra features into the selection menu.
> ## Description:
> Creates a selection menu out of two pages.

&nbsp;
## `<WheelPage>:ToTable()`
<pre>
<cf><<cc>WheelPage</cc>>:ToTable</cf>()
  ► <cc>WheelPageSlotData</cc>[]
</pre>
> ## Returns:
> ### [<cc array link>`WheelPageSlotData`</cc>][@wpsd]
> > An array of the data in each slot of the WheelPage.
> ## Description:
> Returns a copy of the data that makes up the WheelPage. This data can be used to create a clone of this WheelPage.

&nbsp;
## `<WheelPage>.leftSize`
### <cc>`SlotSideNumber`</cc>
> ## Description:
> Contains the left-hand size for the action wheel while this WheelPage is active.

&nbsp;
## `<WheelPage>.rightSize`
### <cc>`SlotSideNumber`</cc>
> ## Description:
> Contains the right-hand size for the action wheel while this WheelPage is active.

&nbsp;
## `<WheelPage>.selectedSlot`
### <cc>`SlotNumber`</cc>
> ## Description:
> Used by selection menus to keep track of the currently active slot.
> It is not recommended to edit this value unless you know what you are doing.

&nbsp;
## `<WheelPage>[number]`
### [<cc link>`WheelPageSlot`</cc>][dwps#wps]
> ## Description:
> Contains a WheelPageSlot in this WheelPage. There are a total of *eight* WheelPageSlots per WheelPage.
