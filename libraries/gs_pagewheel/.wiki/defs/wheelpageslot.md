### [❮ Go back](../../) ❙ [Main Page](../_main.md) ❙ [Definitions](../defs.md)

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
```ts
func(state: boolean)
  ► void
```
> ## Parameters:
> ### `state`
> > ##### `boolean`
> > The new state of the toggle.
> ## Description:
> A function that runs when a toggle slot is activated.

&nbsp;
## `ListFunction`
```ts
func(index: number)
  ► void
```
> ## Parameters:
> ### `index`
> > ##### `number`
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
### [`WheelPageSlot`][dwps#wps]
> Library table description.

&nbsp;
## `<WheelPageSlot>:Build()`
```ts
<WheelPageSlot>:Build(data: WheelPageSlotData)
  ► void
```
> ## Parameters:
> ### `data`
> > ##### [`WheelPageSlotData`][@wpsd]
> > The data to apply to the slot. Data is only replaced if it exists in the `data` given.  
> > I.e. A `data` with a missing function will not replace the function of the slot with nothing.
> ## Description:
> Applies data to the slot, replacing as needed.

&nbsp;
## `<WheelPageSlot>:SetTitle()`
```ts
<WheelPageSlot>:SetTitle(str: string)
  ► void
```
> ## Parameters:
> ### `str`
> > ##### `string`
> > The title to use.
> ## Description:
> Sets the title of this slot.

&nbsp;
## `<WheelPageSlot>:SetItem()`
```ts
<WheelPageSlot>:SetItem(item: ItemStack)
  ► void
```
> ## Parameters:
> ### `item`
> > ##### `ItemStack`
> > The item stack to use.
> ## Description:
> Sets the item icon to use for the slot.

&nbsp;
## `<WheelPageSlot>:SetFunction()`
```ts
<WheelPageSlot>:SetFunction(func: function)
  ► void
```
> ## Parameters:
> ### `func`
> > ##### `function`
> > The function to run.
> ## Description:
> Sets the function that runs when the slot is activated.

&nbsp;
## `<WheelPageSlot>:SetColor()`
```ts
<WheelPageSlot>:SetColor(col: VectorColor)
  ► void
```
> ## Parameters:
> ### `col`
> > ##### `VectorColor`
> > The color to use.
> ## Description:
> Sets the outline color of this slot.

&nbsp;
## `<WheelPageSlot>:SetHoverItem()`
```ts
<WheelPageSlot>:SetHoverItem(item: ItemStack)
  ► void
```
> ## Parameters:
> ### `item`
> > ##### `ItemStack`
> > The item stack to use while hovering.
> ## Description:
> Sets the item icon to use for this slot while it is hovered over.

&nbsp;
## `<WheelPageSlot>:SetHoverColor()`
```ts
<WheelPageSlot>:SetTitle(col: VectorColor)
  ► void
```
> ## Parameters:
> ### `col`
> > ##### `VectorColor`
> > The color to use while hovering.
> ## Description:
> Sets the hovered outline color of this slot.

&nbsp;
## `<WheelPageSlot>:MakeToggle()`
```ts
<WheelPageSlot>:MakeToggle(group: string, page: string|number, slotoff: SlotNumber, sloton: SlotNumber, func?: string|ToggleFunction, startEnabled?: boolean)
  ► void
```
> ## Parameters:
> ### `group`
> > ##### `string`
> > The group to look in for the toggle slots.
> ### `page`
> > ##### `string` **or** `number`
> > The page to look in for the toggle slots.
> ### `slotoff`
> > ##### `SlotNumber`
> > The slot to use for the off state.
> ### `sloton`
> > ##### `SlotNumber`
> > The slot to use for the on state.
> ### *`optional`* `func`
> > ##### `string` **or** [`ToggleFunction`][dwps@tf]
> > The function to run when the slot is toggled. The new state of the toggle slot is passed into the function.  
> > If given a string, it will run the ping with the name of the given string.
> ## Description:
> Creates a slot that toggles between two different states by combining two different slots together.

&nbsp;
## `<WheelPageSlot>:MakeList()`
```ts
<WheelPageSlot>:MakeList(group: string, slots: number, func?: string|ListFunction, startIndex?: number, dontError?: boolean)
  ► void
```
> ## Parameters:
> ### `group`
> > ##### `string`
> > The group to look in for the list slots.
> ### `slots`
> > ##### `number`
> > The amount of slots to pull out of the group.  
> > Slots are pulled out by searching for numbered pages, starting at `1`, and pulling out the slots in order until this number of slots is reached.
> >
> > If this is set to `-1`, as many slots as possible are pulled.
> ### *`optional`* `func`
> > ##### `string` **or** [`ListFunction`][dwps@lf]
> > The function to run when the slot is cycled. The new index of the list slot is passed into the function.  
> > If given a string, it will run the ping with the name of the given string.
> ### *`optional`* `startIndex`
> > ##### `number`
> > The index the list slot should start on when created.
> ### *`optional`* `dontError`
> > ##### `boolean`
> > By default, this function will throw an error if not enough slots are found to fill the list. If this is set, the function will instead silently ignore the error and shrink the list down to fit the new amount found.
> ## Description:
> Creates a list that you can scroll through by taking a group of slots.  
> The slots are taken in order by searching through numbered pages and then taking the slots of the found pages.
>
> The `Function` data of the found slots are ignored.

&nbsp;
## `<WheelPageSlot>:MakeGotoButton()`
```ts
<WheelPageSlot>:MakeGotoButton(group?: string, page?: string|number)
  ► void
```
> ## Parameters:
> ### *`optional`* `group`
> > ##### `string`
> > The group to go to.  
> > If unset, the group will not change. This can be used to go to a different page in the same group.
> ### *`optional`* `page`
> > ##### `string` **or** `number`
> > The page to go to.  
> > If unset, the page id will not change. This can be used to go to the same page id in a different group.
> ## Description:
> Makes a button that goes to a different page.

&nbsp;
## `<WheelPageSlot>:MakePrevButton()`
```ts
<WheelPageSlot>:MakePrevButton()
  ► void
```
> ## Description:
> Makes a button that goes to the previous numbered page in the current group.
>
> If the current page is the first page, it will wrap around to the last page.  
> If the current page is not a numbered page, the button will throw an error.

&nbsp;
## `<WheelPageSlot>:MakeNextButton()`
```ts
<WheelPageSlot>:MakeNextButton()
  ► void
```
> ## Description:
> Makes a button that goes to the next numbered page in the current group.
>
> If the current page is the last page, it will wrap around to the first page.  
> If the current page is not a numbered page, the button will throw an error.

&nbsp;
## `<WheelPageSlot>:MakePingButton()`
```ts
<WheelPageSlot>:MakePingButton(name: string, value?: any)
  ► void
```
> ## Parameters:
> ### `name`
> > ##### `string`
> > The name of the ping function.
> ### *`optional`* `value`
> > ##### `any`
> > The value to send through the ping.
> ## Description:
> Makes a button that runs a ping value. Can optionally send a static value through that ping.

&nbsp;
## `<WheelPageSlot>:ToTable()`
```ts
<WheelPageSlot>:ToTable()
  ► WheelPageSlotData
```
> ## Returns:
> ### [`WheelPageSlotData`][@wpsd]
> > The data in the WheelPageSlot.
> ## Description:
> Returns a copy of the data that makes up the WheelPageSlot. This data can be used to create a clone of this slot.

&nbsp;
## `<WheelPageSlot>.data`
### [`WheelPageSlotData`][@wpsd]
> ## Description:
> The generic data that makes up this slot.

&nbsp;
## `<WheelPageSlot>.slotNumber`
### `SlotNumber`
> ## Description:
> The number of this slot in its containing [`WheelPage`][dwp#wp].

&nbsp;
## `<WheelPageSlot>.toggleState`
### `boolean`
> ## Description:
> The current state of the toggle slot.

&nbsp;
## `<WheelPageSlot>.stateOff`
### [`WheelPageSlotData`][@wpsd]
> ## Description:
> The stored data for the off state of the toggle slot or selection slot.

&nbsp;
## `<WheelPageSlot>.stateOn`
### [`WheelPageSlotData`][@wpsd]
> ## Description:
> The stored data for the on state of the toggle slot or selection slot.

&nbsp;
## `<WheelPageSlot>.list`
### [`WheelPageSlotData[]`][@wpsd]
> ## Description:
> The stored data for each of the items of the list slot.
