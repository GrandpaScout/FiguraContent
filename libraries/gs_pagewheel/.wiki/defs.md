### [❮ Go back](../) ❙ [Main Page](./_main.md)

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
```ts
{ [page: string|number]: WheelPage }
```
> ## Description:
> A table containing a variable amount of [`WheelPage`][dwp#wp] objects indexed by their page id.

## `WheelPageSlotData`
```ts
{
  Title?: string,
  Item?: ItemStack,
  Color?: VectorColor,
  Function?: function,
  HoverItem?: ItemStack,
  HoverColor?: VectorColor
}
```
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
> ##### `table`
> Contains the entire PageWheel library.

&nbsp;
## `PageWheel.New()`
```ts
PageWheel.New(group: string, page: string|number, data?: WheelPageSlotData[])
  ► WheelPage
```
> ## Parameters:
> ### `group`
> > ##### `string`
> > The group name for this Wheel Page.
> ### `page`
> > ##### `string` **or** `number`
> > The page id for this Wheel Page.
> ### *`optional`* `data`
> > ##### [`WheelPageSlotData[]`][@wpsd]
> > The data to load the Wheel Page with when it is created.
> >
> > This is an array of up to 8 [`WheelPageSlotData`][@wpsd] objects.
> ## Returns:
> ### [`WheelPage`][dwp#wp]
> > The resulting WheelPage, for ease of later modification.
> ## Description:
> Creates a new WheelPage object in the given group name and page id.
>
> Optionally allows adding data for the page to start out with.

&nbsp;
## `PageWheel.Get()`
```ts
PageWheel.Get(group: string, page?: string|number)
  ► WheelPageGroup|WheelPage
```
> ## Parameters:
> ### `group`
> > ##### `string`
> > The group name to get.
> ### *`optional`* `page`
> > ##### `string` **or** `number`
> > If this is included, get only the page with this id instead of the entire group.
> ## Returns:
> ### [`WheelPageGroup`][@wpg] **or** [`WheelPage`][dwp#wp]
> > The WheelPage or WheelPage group that was found. If no group or page was found, returns `nil` instead.

&nbsp;
## `PageWheel.Select()`
```ts
PageWheel.Select(group?: string, page?: string|number)
  ► void
```
> ## Parameters:
> ### *`optional`* `group`
> > ##### `string`
> > The group to select.  
> > If this is `nil`, the current group is selected.
> ### *`optional`* `page`
> > ##### `string` **or** `number`
> > The page to select.  
> > If this is `nil`, the current page id is selected.
> ## Description:
> Selects the given WheelPage and makes it the active page on the Action Wheel.  
> Leaving one of the parameters blank will make it not change, allowing quick switching of page ids without having to recall the current group name.

&nbsp;
## `PageWheel.Update()`
```ts
PageWheel.Update(slot?: number)
  ► void
```
> ## Parameters:
> ### *`optional`* `slot`
> > ##### `number`
> > If this is set, only update *this* slot in the Action Wheel.
> ## Description:
> Updates the entire Action Wheel or a slot in it. Useful if a WheelPage updates while it is being used.
