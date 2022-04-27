--==[["GSPageWheel" library by Grandpa Scout (STEAM_1:0:55009667)]]==--                    -<0.1.0>-

---A implementation of Action Wheel pages, toggles, and lists with all kinds of helper functions to
---make this massive library a little easier to use.
---
---Not meant for beginners.
local PageWheel = {}
do
  if false then
    ---The help page for GSPageWheelLib.
    help.library.GSPageWheel = {
      ["class"] = {
        ---@type WheelPage
        ["WheelPage"] = {},

        ---@type WheelPageSlot
        ["WheelPageSlot"] = {},

        ---@type WheelPageSlotData
        ["WheelPageSlotData"] = {}
      }
    }
  end
  ---The active group.
  ---@type string
  PageWheel._GROUP = "main"
  ---The active page in the group.
  ---@type string|number
  PageWheel._PAGE = "main"
  ---@type table<string, table<string|number, WheelPage>>
  PageWheel.group = {}

  ---A table with fields that fill a `WheelPageSlot`.  
  ---All fields are optional.
  ---@class WheelPageSlotData
  ---@field Color? VectorColor
  ---@field Function? function
  ---@field HoverColor? VectorColor
  ---@field HoverItem? ItemStack
  ---@field Item? ItemStack
  ---@field Title? string

  ---A Wheel Page.
  ---@class WheelPage
  ---@field [1] WheelPageSlot
  ---@field [2] WheelPageSlot
  ---@field [3] WheelPageSlot
  ---@field [4] WheelPageSlot
  ---@field [5] WheelPageSlot
  ---@field [6] WheelPageSlot
  ---@field [7] WheelPageSlot
  ---@field [8] WheelPageSlot
  ---@field leftSize SlotSideNumber
  ---@field rightSize SlotSideNumber
  ---@field selectedSlot SlotNumber
  local WheelPage = {}
  local WP_mt = {__index = WheelPage}

  ---A slot on the a Wheel Page.
  ---@class WheelPageSlot
  ---@field data table
  ---@field slotNumber SlotNumber
  ---@field stateOff WheelPageSlotData #Used by toggle slots and selection pages.
  ---@field stateOn WheelPageSlotData #Used by toggle slots and selection pages.
  ---@field list WheelPageSlotData[] #Used by list slots.
  local WheelPageSlot = {}
  local WPS_mt = {__index = WheelPageSlot}

  ---Creates a new Page.
  ---
  ---You can optionally supply a table of up to 8 data tables to instantly fill the page's slots.
  ---
  ---Due to issues, the tables cannot be auto-completed. If you want to look at the fields for the
  ---tables, check out `help.library.GSPageWheel.class.WheelPageSlotData`.
  ---@param group string
  ---@param page string|number
  ---@param data? WheelPageSlotData[]
  ---@return WheelPage
  function PageWheel.New(group, page, data)
    if group == nil then error("bad argument #1 to 'PageWheel.New' (argument cannot be nil)", 2)
    elseif page == nil then error("bad argument #2 to 'PageWheel.New' (argument cannot be nil)", 2)
    end
    if not PageWheel.group[group] then PageWheel.group[group] = {} end
    local pg = setmetatable({leftSize = 4, rightSize = 4}, WP_mt)
    local pgd
    for i=1,8 do
      pgd = data and data[i] or {}
      if type(pgd) ~= "table" then
        error("bad vararg #" .. i .. " to 'PageWheel.New' (expected table, got " .. type(pgd) .. ")", 2)
      end
      pg[i] = setmetatable({data = pgd, slotNumber = i}, WPS_mt)
    end

    PageWheel.group[group][page] = pg
    return pg
  end

  ---Sets the active page.
  ---@param group? string
  ---@param page? string|number
  function PageWheel.Select(group, page)
    group, page = group or PageWheel._GROUP, page or PageWheel._PAGE
    if group == nil then error("bad argument #1 to 'PageWheel.Select' (argument cannot be nil)", 2)
    elseif page == nil then error("bad argument #2 to 'PageWheel.Select' (argument cannot be nil)", 2)
    elseif not (PageWheel.group[group] and PageWheel.group[group][page]) then
      error("page '" .. tostring(group) .. "/" .. tostring(page) .. "' was not found", 2)
    end
    local pg = PageWheel.group[group][page]
    action_wheel.setLeftSize(pg.leftSize)
    action_wheel.setRightSize(pg.rightSize)
    for i=1,8 do
      action_wheel["SLOT_" .. i].clear()
      for f,v in pairs(pg[i].data) do
        action_wheel["SLOT_" .. i]["set" .. f](v)
      end
    end
    PageWheel._GROUP, PageWheel._PAGE = group, page
  end

  ---Updates the action wheel.  
  ---Supplying a slot number only updates that slot.
  ---@param slot? SlotNumber
  function PageWheel.Update(slot)
    if slot then
      if type(slot) ~= "number" then
        error("bad argument #1 to 'PageWheel.Update' (expected number, got " .. type(slot) .. ")", 2)
      elseif slot ~= math.min(math.max(math.floor(slot), 1), 8) then
        error("slot number must be an integer 1..8", 2)
      end
      ---The only reason this exists is because `slot` *insisted* on being a `string|SlotNumber`
      ---without it
      local sslot = tostring(slot)
      action_wheel["SLOT_" .. sslot].clear()
      for f,v in pairs(PageWheel.group[PageWheel._GROUP][PageWheel._PAGE][slot].data) do
        action_wheel["SLOT_" .. sslot]["set" .. f](v)
      end
    else
      for i=1,8 do
        action_wheel["SLOT_" .. i].clear()
        for f,v in pairs(PageWheel.group[PageWheel._GROUP][PageWheel._PAGE][i].data) do
          action_wheel["SLOT_" .. i]["set" .. f](v)
        end
      end
    end

  end

  ---Returns a group or page in a group.
  ---@param group string
  ---@param page? string|number
  ---@return table<string|number, table<number, WheelPageSlot>>|table<number, WheelPageSlot>
  function PageWheel.Get(group, page)
    if group == nil then error("bad argument #1 to 'PageWheel.Get' (argument cannot be nil)", 2) end
    if not PageWheel.group[group] then return end
    if page then return PageWheel.group[group][page] end
  end

  ---Converts the contents of this page into a data table.
  ---@return WheelPageSlotData[]
  function WheelPage:ToTable()
    local tbl = {}
    for i=1,8 do
      tbl[i] = {}
      for f,v in pairs(self[i].data) do tbl[i][f] = v end
    end
    return tbl
  end

  ---`func?: string|function`  
  ---&emsp;Runs the given function or pings the given string, passing in the new number state.
  ---
  ---`startSelect: number`  
  ---&emsp;The slot to start on when this selection is created. This is automatically clamped.
  ---
  ---`ignoredSlots: number[]`  
  ---&emsp;The slots this function should not modify.
  ---***
  ---Creates a selection wheel by combining two pages.
  ---
  ---A selection is a wheel of toggles that only turn off if another toggle is pressed.  
  ---The first page is the unselected state, the second page is the selected state.
  ---
  ---The `Function`s of all slots of the given pages are removed when the selection is created.
  ---
  ---If a field is missing from the same numbered slot of both pages, it will instead be taken from
  ---the same numbered slot from this page and will not change when the selection is activated.
  ---@param group string
  ---@param pageoff string|number
  ---@param pageon string|number
  ---@param func? string|fun(slotid: SlotNumber)
  ---@param startSelect? SlotNumber
  ---@param ignoredSlots? SlotNumber[]
  function WheelPage:MakeSelection(group, pageoff, pageon, func, startSelect, ignoredSlots)
    if group == nil then error("bad argument #1 to 'WheelPage:MakeSelection' (argument cannot be nil)", 2)
    elseif pageoff == nil then error("bad argument #2 to 'WheelPage:MakeSelection' (argument cannot be nil)", 2)
    elseif pageon == nil then error("bad argument #3 to 'WheelPage:MakeSelection' (argument cannot be nil)", 2)
    elseif func and type(func) ~= "function" and type(func) ~= "string" then
      error("bad argument #4 to 'WheelPage:MakeSelection' (expected string or function, got " .. type(func) .. ")", 2)
    elseif startSelect and type(startSelect) ~= "number" then
      error("bad argument #5 to 'WheelPage:MakeSelection' (expected number, got " .. type(startSelect) .. ")", 2)
    elseif ignoredSlots and type(ignoredSlots) ~= "table" then
      error("bad argument #6 to 'WheelPage:MakeSelection' (expected table, got " .. type(ignoredSlots) .. ")", 2)
    end
    local gr = PageWheel.group[group]
    if not gr then
      error("group '" .. tostring(group) .. "' was not found", 2)
    elseif not gr[pageoff] then
      error("page 1 '" .. tostring(group) .. "/" .. tostring(pageoff) .. "' was not found", 2)
    elseif not gr[pageon] then
      error("page 2 '" .. tostring(group) .. "/" .. tostring(pageon) .. "' was not found", 2)
    end

    local pageOff, pageOn = gr[pageoff], gr[pageon]

    local ignore = {}
    if ignoredSlots then
      for _,n in pairs(ignoredSlots) do
        ignore[n] = true
      end
    end
    if #ignore > 7 then error("tried to ingore all slots") end
    if startSelect and ignore[startSelect] then error("tried to start on an ignored slot") end

    ---@type SlotNumber
    local selectedSlot = startSelect or #ignore + 1

    for i=1,8 do
      if not ignore[i] then
        pageOff[i].data.Function, pageOn[i].data.Function = nil, nil
        ---@type WheelPageSlotData
        self[i].stateOff, self[i].stateOn = pageOff[i].data, pageOn[i].data
        self[i]:Build(selectedSlot == i and pageOn[i].data or pageOff[i].data)
        if func then
          if type(func) == "function" then
            self[i].data.Function = function()
              if self.selectedSlot == i then return end
              self[self.selectedSlot]:Build(self[self.selectedSlot].stateOff)
              PageWheel.Update(self.selectedSlot)
              self.selectedSlot = i ---@type SlotNumber
              func(i)
              self[i]:Build(self[i].stateOn)
              PageWheel.Update(i)
            end
          else
            self[i].data.Function = function()
              if self.selectedSlot == i then return end
              self[self.selectedSlot]:Build(self[self.selectedSlot].stateOff)
              PageWheel.Update(self.selectedSlot)
              self.selectedSlot = i ---@type SlotNumber
              ping[func](i)
              self[i]:Build(self[i].stateOn)
              PageWheel.Update(i)
            end
          end
        else
          self[i].data.Function = function()
            if self.selectedSlot == i then return end
            self[self.selectedSlot]:Build(self[self.selectedSlot].stateOff)
            PageWheel.Update(self.selectedSlot)
            self.selectedSlot = i ---@type SlotNumber
            self[i]:Build(self[i].stateOn)
            PageWheel.Update(i)
          end
        end
      end
    end

    self.selectedSlot = selectedSlot
  end

  ---Build the entire slot from the contents of a table.
  ---@param data WheelPageSlotData
  function WheelPageSlot:Build(data)
    if type(data) ~= "table" then return end
    for f,v in pairs(data) do self.data[f] = v end
  end

  ---Converts the data of this slot into a table.
  function WheelPageSlot:ToTable()
    local tbl = {}
    for k, v in pairs(self.data) do
      tbl[k] = v
    end
    return tbl
  end

  ---Sets the color that the slot should be when idle.
  ---@param col VectorColor
  function WheelPageSlot:SetColor(col)
    self.data.Color = col
  end
  ---Sets the function to run when the slot is clicked.
  ---@param func function
  function WheelPageSlot:SetFunction(func)
    self.data.Function = func
  end
  ---Sets the color that the slot should be when hovered over.
  ---@param col VectorColor
  function WheelPageSlot:SetHoverColor(col)
    self.data.HoverColor = col
  end
  ---Sets the item that should appear when the slot is hovered over.
  ---@param item ItemStack
  function WheelPageSlot:SetHoverItem(item)
    self.data.HoverItem = item
  end
  ---Sets the item that should appear when the slot is idle.
  ---@param item ItemStack
  function WheelPageSlot:SetItem(item)
    self.data.Item = item
  end
  ---Sets the title of the slot.
  ---@param str string
  function WheelPageSlot:SetTitle(str)
    self.data.Title = str
  end

  local function nextbutton()
    local page = PageWheel._PAGE
    local group = PageWheel.group[PageWheel._GROUP]
    if type(page) ~= "number" then
      error("tried to find next page in a non-number page '" .. PageWheel._GROUP .. "/" .. page .. "'")
    end
    if #group == 1 then return end
    if page == #group then
      page = 1
    else
      page = page + 1
    end
    PageWheel.Select(nil, page)
  end

  local function prevbutton()
    local page = PageWheel._PAGE
    local group = PageWheel.group[PageWheel._GROUP]
    if type(page) ~= "number" then
      error("tried to find previous page in a non-number page '" .. PageWheel._GROUP .. "/" .. page .. "'")
    end
    if #group == 1 then return end
    if page == 1 then
      page = #group
    else
      page = page - 1
    end
    PageWheel.Select(nil, page)
  end

  ---Inserts a next page function in this slot.  
  ---This function only works on number pages.
  function WheelPageSlot:MakeNextButton()
    self.data.Function = nextbutton
  end

  ---Inserts a previous page function in this slot.  
  ---This function only works on number pages.
  function WheelPageSlot:MakePrevButton()
    self.data.Function = prevbutton
  end

  ---Inserts a page switch function in this slot.  
  ---Set the group or page to `nil` to keep them at the same value.
  ---@param group? string
  ---@param page? string|number
  function WheelPageSlot:MakeGotoButton(group, page)
    self.data.Function = function() PageWheel.Select(group, page) end
  end

  ---Inserts a ping function into this slot.
  ---@param name string
  ---@param value? PingSupported
  function WheelPageSlot:MakePingButton(name, value)
    self.data.Function = value == nil and ping[name] or function() ping[name](value) end
  end

  ---`func?: string|function`  
  ---&emsp;Runs the given function or pings the given string, passing in the new boolean state.
  ---
  ---`startEnabled?: boolean`  
  ---&emsp;Determines if this toggle should already be enabled when it is created.
  ---***
  ---Creates a toggle slot by combining two slots together.  
  ---The first slot is the off state, the second slot is the on state.
  ---
  ---The `Function`s of both given slots are removed when the toggle is created.
  ---
  ---If a field is missing from both given slots, it will instead be taken from this slot and will
  ---not change when the toggle is activated.
  ---@param group string
  ---@param page string|number
  ---@param slotoff SlotNumber
  ---@param sloton SlotNumber
  ---@param func? string|fun(state: boolean)
  ---@param startEnabled? boolean
  function WheelPageSlot:MakeToggle(group, page, slotoff, sloton, func, startEnabled)
    if group == nil then error("bad argument #1 to 'WheelPageSlot:MakeToggle' (argument cannot be nil)", 2)
    elseif page == nil then error("bad argument #2 to 'WheelPageSlot:MakeToggle' (argument cannot be nil)", 2)
    elseif type(slotoff) ~= "number" then error("bad argument #3 to 'WheelPageSlot:MakeToggle' (expected number, got " .. type(slotoff) .. ")", 2)
    elseif type(sloton) ~= "number" then error("bad argument #4 to 'WheelPageSlot:MakeToggle' (expected number, got " .. type(sloton) .. ")", 2)
    elseif func and type(func) ~= "function" and type(func) ~= "string" then
      error("bad argument #5 to 'WheelPageSlot:MakeToggle' (expected string or function, got " .. type(func) .. ")", 2)
    end
    ---@type WheelPage
    local pg = PageWheel.group[group] and PageWheel.group[group][page]
    if not (pg and pg[slotoff]) then
      error("slot 1 '" .. tostring(group) .. "/" .. tostring(page) .. "[" .. tostring(slotoff) .. "]' was not found", 2)
    elseif not (pg and pg[sloton]) then
      error("slot 2 '" .. tostring(group) .. "/" .. tostring(page) .. "[" .. tostring(sloton) .. "]' was not found", 2)
    end
    ---@type WheelPageSlotData
    local stateOff, stateOn = pg[slotoff].data, pg[sloton].data
    stateOff.Function, stateOn.Function = nil, nil

    local toggleFunc
    if func then
      if type(func) == "function" then
        toggleFunc = function()
          self.toggleState = not self.toggleState
          func(self.toggleState)
          self:Build(self.toggleState and self.stateOn or self.stateOff)
          PageWheel.Update(self.slotNumber)
        end
      else
        toggleFunc = function()
          self.toggleState = not self.toggleState
          ping[func](self.toggleState)
          self:Build(self.toggleState and self.stateOn or self.stateOff)
          PageWheel.Update(self.slotNumber)
        end
      end
    else
      toggleFunc = function()
        self.toggleState = not self.toggleState
        self:Build(self.toggleState and self.stateOn or self.stateOff)
        PageWheel.Update(self.slotNumber)
      end
    end

    self:Build(startEnabled and stateOn or stateOff)
    self.data.Function = toggleFunc
    self.toggleState = not not startEnabled
    ---@type WheelPageSlotData
    self.stateOff, self.stateOn = stateOff, stateOn
  end

  ---`slots: number`  
  ---&emsp;The amount of slots to collect, set this to `-1` to get every slot in the given group.
  ---
  ---`func?: string|function`  
  ---&emsp;Runs the given function or pings the given string, passing in the new number state.
  ---
  ---`startIndex: number`  
  ---&emsp;The slot to start on when this list is created. This is automatically clamped.
  ---
  ---`dontError: boolean`  
  ---&emsp;If this function cannot find enough slots, silently succeed instead of erroring.
  ---***
  ---Creates a list that you can scroll through by taking a group of slots.  
  ---The `Function`s of all found slots are removed when the list is created.
  ---
  ---If a field is missing from all of the found slots, it will instead be taken from this slot and
  ---will not change when the list is activated.
  ---
  ---The given group is indexed by number for pages, then those pages are indexed for their slots
  ---until the given number of slots is reached, scrolling to the next page automatically if not
  ---enough slots were collected in the current page.
  ---
  ---As an example, if given the group `"colors"` and a `slots` of 20, the colors group will be
  ---searched like so:
  ---```
  ---colors[1][1], colors[1][2], colors[1][3], colors[1][4], colors[1][5], colors[1][6],
  ---colors[1][7], colors[1][8], colors[2][1], colors[2][2], colors[2][3], colors[2][4],
  ---colors[2][5], colors[2][6], colors[2][7], colors[2][8], colors[3][1], colors[3][2],
  ---colors[3][3], colors[3][4]
  ---```
  ---@param group string
  ---@param slots number
  ---@param func? string|fun(index: number)
  ---@param startIndex? number
  ---@param dontError? boolean
  function WheelPageSlot:MakeList(group, slots, func, startIndex, dontError)
    if group == nil then error("bad argument #1 to 'WheelPageSlot:MakeList' (argument cannot be nil)", 2)
    elseif type(slots) ~= "number" then error("bad argument #2 to 'WheelPageSlot:MakeList' (expected number, got " .. type(slots) .. ")", 2)
    elseif startIndex and type(startIndex) ~= "number" then error("bad argument #3 to 'WheelPageSlot:MakeList' (expected number, got " .. type(startIndex) .. ")", 2)
    elseif not PageWheel.group[group] then error("group '" .. tostring(group) .. "' was not found", 2)
    end

    local list = {}
    local g = PageWheel.group[group]
    for _,p in ipairs(g) do
      for _,s in ipairs(p) do
        list[#list+1] = s.data
        if #list == slots then break end
      end
      if #list == slots then break end
    end
    if not dontError and (#list < slots) then error("not enough slots were found in group '" .. tostring(group) .. "'") end

    local indexFunc
    if func then
      if type(func) == "function" then
        indexFunc = function()
          self.index = self.index == #self.list and 1 or self.index + 1
          func(self.index)
          self:Build(self.list[self.index])
          PageWheel.Update(self.slotNumber)
        end
      else
        indexFunc = function()
          self.index = self.index == #self.list and 1 or self.index + 1
          ping[func](self.index)
          self:Build(self.list[self.index])
          PageWheel.Update(self.slotNumber)
        end
      end
    else
      indexFunc = function()
        self.index = self.index == #self.list and 1 or self.index + 1
        self:Build(self.list[self.index])
        PageWheel.Update(self.slotNumber)
      end
    end

    self.index = math.min(math.max(math.floor(startIndex or 1), 1), #list)
    self:Build(list[self.index])
    self.data.Function = indexFunc
    self.list = list
  end
end
---Lets other scripts know that this has loaded in if they depend on it.
---@diagnostic disable-next-line: unused-local
local LIB_GSPAGEWHEEL = "0.1.0"
