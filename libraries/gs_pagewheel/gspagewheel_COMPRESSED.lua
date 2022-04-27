--==[["GSPageWheel" library by Grandpa Scout (STEAM_1:0:55009667)]]==--                    -<0.1.0>-

local PageWheel = {}
do
  PageWheel._GROUP,PageWheel._PAGE,PageWheel.group="main","main",{}
  local WheelPage,WheelPageSlot={}
  local WP_mt,WPS_mt={__index = WheelPage},{__index = WheelPageSlot}
  function PageWheel.New(gid,pid,dt)
    if gid==nil then;error("bad argument #1 to 'PageWheel.New' (argument cannot be nil)",2)
    elseif pid==nil then;error("bad argument #2 to 'PageWheel.New' (argument cannot be nil)",2)end
    if not PageWheel.group[gid]then;PageWheel.group[gid]={}end;local pg,pgd=setmetatable({leftSize=4,rightSize=4},WP_mt)
    for i=1,8 do;pgd=dt and dt[i]or{}
      if type(pgd)~="table"then;error("bad vararg #"..i.." to 'PageWheel.New' (expected table, got "..type(pgd)..")",2)end
      pg[i]=setmetatable({data=pgd,slotNumber=i},WPS_mt)
    end
    PageWheel.group[gid][pid] = pg;return pg
  end
  function PageWheel.Select(gid,pid)
    gid,pid=gid or PageWheel._GROUP,pid or PageWheel._PAGE
    if gid==nil then;error("bad argument #1 to 'PageWheel.Select' (argument cannot be nil)",2)
    elseif pid==nil then;error("bad argument #2 to 'PageWheel.Select' (argument cannot be nil)",2)
    elseif not(PageWheel.group[gid]and PageWheel.group[gid][pid])then;error("page '"..tostring(gid).."/"..tostring(pid).."' was not found",2)end
    local pg = PageWheel.group[gid][pid]action_wheel.setLeftSize(pg.leftSize)action_wheel.setRightSize(pg.rightSize)
    for i=1,8 do;action_wheel["SLOT_"..i].clear()for f,v in pairs(pg[i].data)do;action_wheel["SLOT_"..i]["set"..f](v)end;end
    PageWheel._GROUP,PageWheel._PAGE=gid,pid
  end
  function PageWheel.Update(slot)
    if slot then
      if type(slot)~="number"then;error("bad argument #1 to 'PageWheel.Update' (expected number, got "..type(slot)..")",2)
      elseif slot ~= math.min(math.max(math.floor(slot), 1), 8) then;error("slot number must be an integer 1..8",2)end
      local sslot=tostring(slot)action_wheel["SLOT_"..sslot].clear()
      for f,v in pairs(PageWheel.group[PageWheel._GROUP][PageWheel._PAGE][slot].data)do;action_wheel["SLOT_"..sslot]["set"..f](v)end
    else
      for i=1,8 do;action_wheel["SLOT_" .. i].clear()
        for f,v in pairs(PageWheel.group[PageWheel._GROUP][PageWheel._PAGE][i].data)do;action_wheel["SLOT_"..i]["set"..f](v)end
      end
    end
  end
  function PageWheel.Get(gid,pid)
    if gid==nil then;error("bad argument #1 to 'PageWheel.Get' (argument cannot be nil)",2)end
    if not PageWheel.group[gid]then;return;end;if pid then return PageWheel.group[gid][pid]end
  end
  function WheelPage:ToTable()local tbl={}for i=1,8 do;tbl[i]={}for f,v in pairs(self[i].data)do tbl[i][f]=v end;end;return tbl;end
  function WheelPage:MakeSelection(gid,pgof,pgon,fn,stsl,igsl)
    if gid==nil then;error("bad argument #1 to 'WheelPage:MakeSelection' (argument cannot be nil)",2)
    elseif pgof==nil then;error("bad argument #2 to 'WheelPage:MakeSelection' (argument cannot be nil)",2)
    elseif pgon==nil then;error("bad argument #3 to 'WheelPage:MakeSelection' (argument cannot be nil)",2)
    elseif fn and type(fn)~="function"and type(fn)~="string"then;error("bad argument #4 to 'WheelPage:MakeSelection' (expected string or function, got "..type(fn)..")",2)
    elseif stsl and type(stsl)~="number"then;error("bad argument #5 to 'WheelPage:MakeSelection' (expected number, got "..type(stsl)..")",2)
    elseif igsl and type(igsl)~="table"then;error("bad argument #6 to 'WheelPage:MakeSelection' (expected table, got "..type(igsl)..")",2)end
    local gr=PageWheel.group[gid]if not gr then;error("group '"..tostring(gid).."' was not found",2)
    elseif not gr[pgof]then;error("page 1 '"..tostring(gid).."/"..tostring(pgof).."' was not found",2)
    elseif not gr[pgon]then;error("page 2 '"..tostring(gid).."/"..tostring(pgon).."' was not found",2)end
    local pOff,pOn,ign=gr[pgof],gr[pgon],{}if igsl then;for _,n in pairs(igsl)do;ign[n]=true;end;end
    if#ign>7 then;error("tried to ingore all slots")end;if stsl and ign[stsl]then;error("tried to start on an ignored slot")end
    local sS = stsl or#ign+1
    for i=1,8 do
      if not ign[i] then
        pOff[i].data.Function,pOn[i].data.Function,self[i].stateOff,self[i].stateOn=nil,nil,pOff[i].data,pOn[i].data
        self[i]:Build(sS==i and pOn[i].data or pOff[i].data)
        if fn then
          if type(fn)=="function"then
            self[i].data.Function=function()
              if self.selectedSlot==i then return end;self[self.selectedSlot]:Build(self[self.selectedSlot].stateOff)PageWheel.Update(self.selectedSlot)
              self.selectedSlot=i;fn(i)self[i]:Build(self[i].stateOn)PageWheel.Update(i)
            end
          else
            self[i].data.Function=function()
              if self.selectedSlot==i then return end;self[self.selectedSlot]:Build(self[self.selectedSlot].stateOff)PageWheel.Update(self.selectedSlot)
              self.selectedSlot=i;ping[fn](i)self[i]:Build(self[i].stateOn)PageWheel.Update(i)
            end
          end
        else
          self[i].data.Function = function()
            if self.selectedSlot==i then return end;self[self.selectedSlot]:Build(self[self.selectedSlot].stateOff)PageWheel.Update(self.selectedSlot)
            self.selectedSlot=i;self[i]:Build(self[i].stateOn)PageWheel.Update(i)
          end
        end
      end
    end
    self.selectedSlot = sS
  end
  function WheelPageSlot:Build(d)if type(d)~="table"then return end;for f,v in pairs(d)do self.data[f]=v end;end
  function WheelPageSlot:ToTable()local t={}for k, v in pairs(self.data)do;t[k]=v;end;return t;end
  function WheelPageSlot:SetColor(col)self.data.Color=col;end
  function WheelPageSlot:SetFunction(func)self.data.Function=func;end
  function WheelPageSlot:SetHoverColor(col)self.data.HoverColor=col;end
  function WheelPageSlot:SetHoverItem(item)self.data.HoverItem=item;end
  function WheelPageSlot:SetItem(item)self.data.Item=item;end
  function WheelPageSlot:SetTitle(str)self.data.Title=str;end
  local function nxB()
    local pg,gp=PageWheel._PAGE,PageWheel.group[PageWheel._GROUP]
    if type(pg)~="number"then;error("tried to find next page in a non-number page '"..PageWheel._GROUP.."/"..pg.."'")end
    if#gp==1 then return end;if pg==#gp then;pg=1;else;pg=pg+1;end;PageWheel.Select(nil,pg)
  end
  local function pvB()
    local pg,gp=PageWheel._PAGE,PageWheel.group[PageWheel._GROUP]
    if type(pg)~="number"then;error("tried to find previous page in a non-number page '"..PageWheel._GROUP.."/"..pg.."'")end
    if#gp==1 then return end;if pg==1 then;pg=#gp;else;pg=pg-1;end;PageWheel.Select(nil,pg)
  end
  function WheelPageSlot:MakeNextButton()self.data.Function=nxB;end;function WheelPageSlot:MakePrevButton()self.data.Function=pvB;end
  function WheelPageSlot:MakeGotoButton(gp,pg)self.data.Function=function()PageWheel.Select(gp,pg)end;end
  function WheelPageSlot:MakePingButton(n,v)self.data.Function=v==nil and ping[n]or function()ping[n](v)end;end
  function WheelPageSlot:MakeToggle(grp,pge,soff,son,fn,sE)
    if grp==nil then;error("bad argument #1 to 'WheelPageSlot:MakeToggle' (argument cannot be nil)",2)
    elseif pge==nil then;error("bad argument #2 to 'WheelPageSlot:MakeToggle' (argument cannot be nil)",2)
    elseif type(soff)~="number"then;error("bad argument #3 to 'WheelPageSlot:MakeToggle' (expected number, got "..type(soff)..")",2)
    elseif type(son)~="number"then;error("bad argument #4 to 'WheelPageSlot:MakeToggle' (expected number, got "..type(son)..")",2)
    elseif fn and type(fn)~="function"and type(fn)~="string"then;error("bad argument #5 to 'WheelPageSlot:MakeToggle' (expected string or function, got "..type(fn)..")",2)end
    local pg=PageWheel.group[grp]and PageWheel.group[grp][pge]
    if not(pg and pg[soff])then;error("slot 1 '"..tostring(grp).."/"..tostring(pge).."["..tostring(soff).."]' was not found",2)
    elseif not(pg and pg[son])then;error("slot 2 '"..tostring(grp).."/"..tostring(pge).."["..tostring(son).."]' was not found",2)end
    local stOff,stOn,tF=pg[soff].data,pg[son].data;stOff.Function,stOn.Function=nil,nil
    if fn then
      if type(fn)=="function"then
        tF=function()self.toggleState=not self.toggleState;fn(self.toggleState)self:Build(self.toggleState and self.stateOn or self.stateOff)PageWheel.Update(self.slotNumber)end
      else
        tF=function()self.toggleState=not self.toggleState;ping[fn](self.toggleState)self:Build(self.toggleState and self.stateOn or self.stateOff)PageWheel.Update(self.slotNumber)end
      end
    else
      tF=function()self.toggleState=not self.toggleState;self:Build(self.toggleState and self.stateOn or self.stateOff)PageWheel.Update(self.slotNumber)end
    end
    self:Build(sE and stOn or stOff)self.data.Function,self.toggleState,self.stateOff,self.stateOn=tF,not not sE,stOff,stOn
  end
  function WheelPageSlot:MakeList(gp,st,fn,sI,dE)
    if gp==nil then;error("bad argument #1 to 'WheelPageSlot:MakeList' (argument cannot be nil)",2)
    elseif type(st)~="number"then;error("bad argument #2 to 'WheelPageSlot:MakeList' (expected number, got "..type(st)..")",2)
    elseif sI and type(sI)~="number"then;error("bad argument #3 to 'WheelPageSlot:MakeList' (expected number, got "..type(sI)..")",2)
    elseif not PageWheel.group[gp]then;error("group '"..tostring(gp).."' was not found",2)end
    local list,g={},PageWheel.group[gp]
    for _,p in ipairs(g)do
      for _,s in ipairs(p)do;list[#list+1]=s.data;if#list==st then break end;end
      if#list==st then break end
    end
    if not dE and(#list<st)then;error("not enough slots were found in group '"..tostring(gp).."'")end
    local iF
    if fn then
      if type(fn)=="function"then
        iF=function()self.index=self.index==#self.list and 1 or self.index+1;fn(self.index)self:Build(self.list[self.index])PageWheel.Update(self.slotNumber)end
      else
        iF=function()self.index=self.index==#self.list and 1 or self.index+1;ping[fn](self.index)self:Build(self.list[self.index])PageWheel.Update(self.slotNumber)end
      end
    else
      iF=function()self.index=self.index==#self.list and 1 or self.index+1;self:Build(self.list[self.index])PageWheel.Update(self.slotNumber)end
    end
    self.index=math.min(math.max(math.floor(sI or 1),1),#list)self:Build(list[self.index])self.data.Function,self.list=iF,list
  end
end
local LIB_GSPAGEWHEEL = "0.1.0"
