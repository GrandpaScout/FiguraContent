### [❮ Go back](../../) ❙ [Main Page](../_main.md) ❙ [Definitions](../defs.md)

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
```ts
func(slotid: SlotNumber)
  ► void
```
> ## Parameters:
> ### `slotid`
> > ##### `SlotNumber`
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
### [`WheelPage`][dwp#wp]
> A WheelPage instance. This is a container object for [`WheelPageSlot`][dwps#wps] object of the PageWheel system.

&nbsp;
## `<WheelPage>:MakeSelection()`
```ts
<WheelPage>:MakeSelection(group: string, pageoff: string|number, pageon: string|number, func?: string|SelectionFunction, startSelect?: SlotNumber, ignoredSlots?: SlotNumber[])
  ► void
```
> ## Parameters:
> ### `group`
> > ##### `string`
> > The group to look in for the selection pages.
> ### `pageoff`
> > ##### `string` **or** `number`
> > The page used for the off state of the selection slots.
> ### `pageon`
> > ##### `string` **or** `number`
> > The page used for the on state of the selection slots.
> ### *`optional`* `func`
> > ##### `string` **or** `SelectionFunction`
> > The function to run when a slot is selected. The number of the activating slot is passed into the function.  
> > If given a string, it will run the ping with the name of the given string.  
> > This function will not run if an already selected slot is clicked again.
> ### *`optional`* `startSelect`
> > ##### `SlotNumber`
> > The slot to start on when this selection is created. This is automatically clamped.
> > If this is left blank, the first available slot will be made the starting slot.
> ### *`optional`* `ignoredSlots`
> > ##### `SlotNumber[]`
> > An array of slot numbers to ignore while making the selection. Useful for embedding extra features into the selection menu.
> ## Description:
> Creates a selection menu out of two pages.

&nbsp;
## `<WheelPage>:ToTable()`
```ts
<WheelPage>:ToTable()
  ► WheelPageSlotData[]
```
> ## Returns:
> ### [`WheelPageSlotData[]`][@wpsd]
> > An array of the data in each slot of the WheelPage.
> ## Description:
> Returns a copy of the data that makes up the WheelPage. This data can be used to create a clone of this page.

&nbsp;
## `<WheelPage>.leftSize`
### `SlotSideNumber`
> ## Description:
> Contains the left-hand size for the action wheel while this WheelPage is active.

&nbsp;
## `<WheelPage>.rightSize`
### `SlotSideNumber`
> ## Description:
> Contains the right-hand size for the action wheel while this WheelPage is active.

&nbsp;
## `<WheelPage>.selectedSlot`
### `SlotNumber`
> ## Description:
> Used by selection menus to keep track of the currently active slot.
> It is not recommended to edit this value unless you know what you are doing.

&nbsp;
## `<WheelPage>[number]`
### [`WheelPageSlot`][dwps#wps]
> ## Description:
> Contains a WheelPageSlot in this WheelPage. There are a total of *eight* WheelPageSlots per WheelPage.
