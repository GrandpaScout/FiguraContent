### [❮ Go back](../) ❙ [Main Page](./_main.md)

# GSName: Examples
[#pwn]: ./defs.md#pagewheelnew
[#pws]: ./defs.md#pagewheelselect
[#pwu]: ./defs.md#pagewheelupdate

[dwp#wpms]: ./defs/wheelpage.md#wheelpagemakeselection
[dwp.wpls]: ./defs/wheelpage.md#wheelpageleftsize

[dwps#wpsmgb]: ./defs/wheelpageslot.md#wheelpageslotmakegotobutton
[dwps#wpsml]: ./defs/wheelpageslot.md#wheelpageslotmakelist

### Creating a Selection Page
Creates two pages for use in a selection page, with a slot open for a back button if needed.  
The off page has a black colored border while the on page has a green colored border
> ## Uses:
> * [`PageWheel.New()`][#pwn]
> * [`PageWheel.Select()`][#pws]
> * [`<WheelPage>:MakeSelection()`][dwp#wpms]
> * [`<WheelPage>.leftSize`][dwp.wpls]
> * [`<WheelPageSlot>:MakeGotoButton()`][dwps#wpsmgb]
```lua
--Create the off state.
PageWheel.New("selection", "oreOff", {
  {Title = "Iron", Color = vectors.of{}, Item = "iron_ingot"},
  {Title = "Gold", Color = vectors.of{}, Item = "gold_ingot"},
  {Title = "Diamond", Color = vectors.of{}, Item = "diamond"},
  {Title = "Emerald", Color = vectors.of{}, Item = "emerald"},
  {Title = "Netherite", Color = vectors.of{}, Item = "netherite_ingot"},
  nil, --Leave this slot blank to make room for a back button.
  {Title = "Coal", Color = vectors.of{}, Item = "coal"}
})
--Create the on state.
PageWheel.New("selection", "oreOn", {
  {Title = "Iron", Color = vectors.of{0, 1}, Item = "iron_ingot"},
  {Title = "Gold", Color = vectors.of{0, 1}, Item = "gold_ingot"},
  {Title = "Diamond", Color = vectors.of{0, 1}, Item = "diamond"},
  {Title = "Emerald", Color = vectors.of{0, 1}, Item = "emerald"},
  {Title = "Netherite", Color = vectors.of{0, 1}, Item = "netherite_ingot"},
  nil, --Leave this slot blank to make room for a back button.
  {Title = "Coal", Color = vectors.of{0, 1}, Item = "coal"}
})

--Create the base for the Selection Page.
local SelectionPage = PageWheel.New("main", "select_ore", {
  nil, nil, nil, nil, nil, --Do nothing with these slots.
  {Title = "Back", Item = "barrier"} --Create the base for the back button.
})

SelectionPage.leftSize = 3 --Set the left side to only contain 3 slots.

--Creates the Selection Page by taking the "oreOff" and "oreOn" pages
-- from the "selection" group and then attaches a function that prints
-- the index selected.
--This Selection Page is set to select slot 7 immediately after creation
-- and ignore slots 6 and 8 during creation.
SelectionPage:MakeSelection("selection", "oreOff", "oreOn", function(index)
  print(("Selected ore %d"):format(index))
end, 7, {6, 8})

--Make the back button in slot 6.
SelectionPage[6]:MakeGotoButton(nil, "main")

--Select the page to test it out.
PageWheel.Select("main", "select_ore")
```
***
### Example 2 Title
This is another example of what this library can do.
> ## Uses:
> * [`PageWheel.New()`][#pwn]
> * [`PageWheel.Update()`][#pwu]
> * [`<WheelPageSlot>:MakeList()`][dwps#wpsml]
```lua
--Create pages to store the list elements.
PageWheel.New("list_pickColor", 1, {
  {Title = "Red", Color = vectors.of{1}, Item = "red_dye"},
  {Title = "Orange", Color = vectors.of{1, 0.5}, Item = "orange_dye"},
  {Title = "Yellow", Color = vectors.of{1, 1}, Item = "yellow_dye"},
  {Title = "Green", Color = vectors.of{0, 1}, Item = "green_dye"},
  {Title = "Cyan", Color = vectors.of{0, 0.5, 0.5}, Item = "cyan_dye"},
  {Title = "Blue", Color = vectors.of{0, 0, 1}, Item = "blue_dye"},
  {Title = "Purple", Color = vectors.of{0.5, 0, 0.75}, Item = "purple_dye"},
  {Title = "Magenta", Color = vectors.of{1, 0, 1}, Item = "magenta_dye"}
})
PageWheel.New("list_pickColor", 2, {
  {Title = "Pink", Color = vectors.of{1, 0.5, 0.75}, Item = "pink_dye"},
  {Title = "Brown", Color = vectors.of{0.5, 0.25}, Item = "brown_dye"},
  {Title = "White", Color = vectors.of{1, 1, 1}, Item = "white_dye"},
  {Title = "Black", Color = vectors.of{0}, Item = "black_dye"}
})

--Create "main/main" so it can be used properly.
local MainPage = PageWheel.New("main", "main")

--Create the List Slot. This list will search the "list_pickColor" group
-- for numbered pages containing slots and will grab as many slots as
-- possible.
--This function will run "ping.color" with the new list index when the
-- list is cycled.
MainPage[1]:MakeList("list_pickColor", -1, "color")

--Update the first slot since "main/main" is already selected by default.
PageWheel.Update(1)

--Create ping.color for use by the List Slot.
function ping.color(index)
  print(("Color %d selected"):format(index))
end
```
***
