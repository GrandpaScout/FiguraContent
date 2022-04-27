--==[["GSTimer" library by Grandpa Scout (STEAM_1:0:55009667)]]==--                        -<0.1.0>-

---A timer object. This keeps track of the time and triggers its stored function when the given time
---is reached.
---@class Timer
---The timer's time remaining.
---@field private _REMAINING number
---The timer's max time.
---@field private _TOTAL number
---If this timer will not update.
---@field private _STOPPED boolean
---How many times this timer repeats instead of stopping.
---@field private _LOOPS boolean
---The function this timer runs.
---@field private _FUNC function
local Timer = {}
---@diagnostic disable-next-line: unused-local
local UpdateAllTimers
do
  local T_mt = {__index = Timer}
  local timer_list = {}

  ---`ticks: number`  
  ---&emsp;The amount of times this timer needs to be updated before it will run its function.
  ---
  ---`loops: number`  
  ---&emsp;The amount of times this timer will automatically restart. Leave blank to not have it
  ---restart automatically, or set it to `-1` to have it restart infinitely.
  ---***
  ---Creates a new timer with the specified amount of ticks before triggering.  
  ---You can optionally add automatic looping.
  ---@param ticks number
  ---@param func? function
  ---@param loops? number
  ---@return Timer
  function Timer:New(ticks, func, loops)
    if type(ticks) ~= "number" then
      error("Bad argument #1 to 'Timer:New' (number expected, got " .. type(ticks) .. ")", 2)
    elseif type(func) ~= "function" then
      error("Bad argument #2 to 'Timer:New' (function expected, got " .. type(func) .. ")", 2)
    end
    loops = math.floor(tonumber(loops) or 0)
    local thistimer = setmetatable({
      _TOTAL = ticks, _REMAINING = ticks, _STOPPED = false, _LOOPS = loops,
      _FUNC = func
    }, T_mt)
    timer_list[#timer_list+1] = thistimer
    return thistimer
  end

  ---Updates the timer.
  function Timer:Update()
    if self._STOPPED then return end
    self._REMAINING = self._REMAINING - 1
    if self._REMAINING <= 0 then
      if self._FUNC then self._FUNC() end
      if self._LOOPS ~= 0 then
        if self._LOOPS > 0 then self._LOOPS = self._LOOPS - 1 end
        self._REMAINING = self._TOTAL
      else
        self._STOPPED = true
      end
    end
  end

  ---Restarts the timer.  
  ---Optionally supply a number of loops for the timer.
  ---@param loops? number
  function Timer:Restart(loops)
    loops = tonumber(loops) and math.floor(tonumber(loops)) or nil
    self._STOPPED, self._REMAINING = false, self._TOTAL
    if loops then self._LOOPS = loops end
  end

  ---Pauses the timer.
  function Timer:Pause() self._STOPPED = true end
  ---Stops the timer
  function Timer:Stop() self._STOPPED, self._REMAINING, self._LOOPS = true, 0, 0 end
  ---Resumes the timer.  
  ---You cannot resume a stopped timer, you will need to `:Restart()` it instead.
  function Timer:Resume()
    if self._REMAINING > 0 or self._LOOPS ~= 0 then self._STOPPED = false end
  end
  ---Returns the current state of the timer.
  ---@return
  ---| '"running"' #The timer is active.
  ---| '"paused"' #The timer is paused and can resume.
  ---| '"stopped"' #The timer is stopped and cannot resume.
  function Timer:State()
    if not self._STOPPED then
      return "running"
    elseif self._REMAINING > 0 or self._LOOPS ~= 0 then
      return "paused"
    else
      return "stopped"
    end
  end

  ---`of: Timer[]`  
  ---&emsp;An array of timers you want to update.
  ---***
  ---Updates all or selected timers.
  ---@param of? Timer[]
  ---@diagnostic disable-next-line: unused-local
  function UpdateAllTimers(of)
    for _,t in ipairs(of or timer_list) do
      t:Update()
    end
  end
end
---Lets other scripts know that this has loaded in if they depend on it.
---@diagnostic disable-next-line: unused-local
local LIB_GSTIMER = "0.1.0"
