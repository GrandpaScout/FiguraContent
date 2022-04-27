### [❮ Go back](../)

# GSPageWheel: Wiki
[#pwn]: ./defs.md#pagewheelnew
[#pws]: ./defs.md#pagewheelselect

[dwp#wp]: ./defs/wheelpage.md#wheelpage
[dwp#wpms]: ./defs/wheelpage.md#wheelpagemakeselection

[dwps#wps]: ./defs/wheelpageslot.md#wheelpageslot
[dwps#wpsb]: ./defs/wheelpageslot.md#wheelpageslotbuild
[dwps#wpsmt]: ./defs/wheelpageslot.md#wheelpageslotmaketoggle
[dwps#wpsmgb]: ./defs/wheelpageslot.md#wheelpageslotgotobutton

#### This wiki is updated to version `0.1.0`
> ### Pages:
> * [**Definitions**](./defs.md)
> * [**Examples**](./examples.md)

GSPageWheel adds a page system to Figura's Action Wheel. It also includes extra slot types such as selection slots, toggle slots, list slots, and more.

The Page Wheel system does not start with a page, but the current active page is always set to `main/main` when first started. You can either add that page and update the wheel, or change to a custom page of your choosing.

Use [`PageWheel.New(group, page, data?)`][#pwn] to create a new page.  
Use [`PageWheel.Select(group?, page?)`][#pws] to select a page and show it on the action wheel.  

Use [`<WheelPage>:MakeSelection(group, pageoff, pageon, func?, startSelect?, ignoredSlots?)`][dwp#wpms] to make a selection menu.

Use [`<WheelPageSlot>:Build(data)`][dwps#wpsb] to make a normal action wheel slot or set defaults for a special slot.  
Use [`<WheelPageSlot>:MakeToggle(group, page, slotoff, sloton, func?, startEnabled?)`][dwps#wpsmt] to make a togglable action wheel slot.  
Use [`<WheelPageSlot>:MakeGotoButton(group?, page?)`][dwps#wpsmgb] to make a button that opens a different page.

Not every function can be listed here, check out the [`WheelPage`][dwp#wp] and [`WheelPageSlot`][dwps#wps] definitions for more functions.
