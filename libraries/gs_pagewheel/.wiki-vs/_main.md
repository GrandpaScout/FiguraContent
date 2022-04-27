### [❮ Go back](../README.md)

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

Use [<code link ulink><cf>PageWheel.New</cf>(<ca>group</ca>, <ca>page</ca>, <ca aopt>data</ca>)</code>][#pwn] to create a new page.  
Use [<code link ulink><cf>PageWheel.Select</cf>(<ca aopt>group</ca>, <ca aopt>page</ca>)</code>][#pws] to select a page and show it on the action wheel.  

Use [<code link ulink><cf><<cc>WheelPage</cc>>:MakeSelection</cf>(<ca>group</ca>, <ca>pageoff</ca>, <ca>pageon</ca>, <ca aopt>func</ca>, <ca aopt>startSelect</ca>, <ca aopt>ignoredSlots</ca>)</code>][dwp#wpms] to make a selection menu.

Use [<code link ulink><cf><<cc>WheelPageSlot</cc>>:Build</cf>(<ca>data</ca>)</code>][dwps#wpsb] to make a normal action wheel slot or set defaults for a special slot.  
Use [<code link ulink><cf><<cc>WheelPageSlot</cc>>:MakeToggle</cf>(<ca>group</ca>, <ca>page</ca>, <ca>slotoff</ca>, <ca>sloton</ca>, <ca aopt>func</ca>, <ca aopt>startEnabled</ca>)</code>][dwps#wpsmt] to make a togglable action wheel slot.  
Use [<code link ulink><cf><<cc>WheelPageSlot</cc>>:MakeGotoButton</cf>(<ca aopt>group</ca>, <ca aopt>page</ca>)</code>][dwps#wpsmgb] to make a button that opens a different page.

Not every function can be listed here, check out the [<cc link>`WheelPage`</cc>][dwp#wp] and [<cc link>`WheelPageSlot`</cc>][dwps#wps] definitions for more functions.
