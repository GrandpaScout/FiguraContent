--==[["GSTimer" library by Grandpa Scout (STEAM_1:0:55009667)]]==--                        -<0.1.0>-

local Timer,UpdateAllTimers={}
do
  local T_mt,t_l={__index=Timer},{}
  function Timer:New(t, f, l)
    if type(t)~="number"then;error("Bad argument #1 to 'Timer:New' (number expected, got "..type(t) ..")",2)
    elseif type(f)~="function"then;error("Bad argument #2 to 'Timer:New' (function expected, got "..type(f) ..")",2)end
    l=math.floor(tonumber(l)or 0)
    local T=setmetatable({_TOTAL=t,_REMAINING=t,_STOPPED=false,_LOOPS=l,_FUNC=f},T_mt)t_l[#t_l+1]=T;return T
  end
  function Timer:Update()
    if self._STOPPED then return end
    self._REMAINING=self._REMAINING-1
    if self._REMAINING<=0 then
      if self._FUNC then self._FUNC()end
      if self._LOOPS ~= 0 then;if self._LOOPS>0 then self._LOOPS=self._LOOPS-1 end;self._REMAINING=self._TOTAL
      else;self._STOPPED=true;end
    end
  end
  function Timer:Restart(l)l,self._STOPPED,self._REMAINING=tonumber(l)and math.floor(tonumber(l))or nil,false,self._TOTAL;if l then self._LOOPS=l end;end
  function Timer:Pause()self._STOPPED=true end
  function Timer:Stop()self._STOPPED,self._REMAINING,self._LOOPS=true,0,0 end
  function Timer:Resume()if self._REMAINING>0 or self._LOOPS~=0 then self._STOPPED=false end;end
  function Timer:State()if not self._STOPPED then;return"running"elseif self._REMAINING>0 or self._LOOPS~=0 then;return"paused"else;return"stopped"end;end
  function UpdateAllTimers(o)for _,t in ipairs(o or t_l)do;t:Update()end;end
end
local LIB_GSTIMER = "0.1.0"
