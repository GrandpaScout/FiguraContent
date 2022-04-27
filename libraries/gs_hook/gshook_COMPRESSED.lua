--==[["GSHook" library by Grandpa Scout (STEAM_1:0:55009667)]]==--                         -<0.1.0>-
-- (Figura port of Garry Newman's Hook library)

local hook = {}
do;local ho,ht,sHO={},{},function(a,b)local an,bn=type(a)=="number",type(b)=="number"if an==bn then;return a<b;else;return an;end;end
  function hook.add(hk,id,fn)
    if type(hk)~="string"then;error("bad argument #1 to 'hook.Add' (expected string, got "..type(hk)..")",2)
    elseif type(id)~="string"and type(id)~="number"then;error("bad argument #2 to 'hook.Add' (expected number or string, got "..type(id)..")",2)
    elseif type(fn)~="function"then;error("bad argument #3 to 'hook.Add' (expected function, got "..type(fn)..")",2)end
    if not ht[hk]then;ht[hk],ho[hk]={},{}end;ht[hk][id],ho[hk][#ho[hk]+1]=fn,id;table.sort(ho[hk],sHO)
  end
  function hook.getTable()return ht;end
  function hook.remove(hk,id)
    if type(hk)~="string"then;error("bad argument #1 to 'hook.Remove' (expected string, got " .. type(hk) .. ")", 2)
    elseif type(id)~="string"and type(id)~="number"then;error("bad argument #2 to 'hook.Remove' (expected number or string, got "..type(id)..")",2)end
    if not(ht[hk]and ht[hk][id])then return end;ht[hk][id]=nil;for i,v in ipairs(ho[hk])do;if v==id then table.remove(ho[hk],i)break end end
  end
  function hook.run(hk,...)
    if type(hk)~="string"then;error("bad argument #1 to 'hook.Run' (expected string, got "..type(hk)..")",2)end
    local hks,ord=ht[hk],ho[hk]
    if hks then;local r1,r2,r3,r4,r5,r6 for _,f in pairs(ord)do;r1,r2,r3,r4,r5,r6=hks[f](...)if r1~=nil then return r1,r2,r3,r4,r5,r6 end end end
  end
end
local LIB_GSHOOK = "0.1.0"
