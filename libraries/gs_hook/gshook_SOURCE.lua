--==[["GSHook" library by Grandpa Scout (STEAM_1:0:55009667)]]==--                         -<0.1.0>-

---A hook implementation similar to Garry Newman's Hook library in Garry's Mod.
---
---Hooks are functions that run other functions and return the first non-nil result from any of the
---functions.  
---More detailed explaination of this library is available on
---[the Garry's Mod Wiki](https://wiki.facepunch.com/gmod/hook)
---
---Note: This library has a few differences from the GMod hook library:
---* Function names are camelCase.
---* `hook.call` does not exist since there are no gamemode hooks.
---* `number` identifiers are run in numerical order first.
---* `string` identifiers are run in their character order second.
---* Only `string` and `number` identifiers are allowed.
local hook = {}
do
  local hooktableorder = {}

  ---@type table<string, table<string|number, function>>
  local hooktable = {}

  local function sortHookOrder(a, b)
    local anum, bnum = type(a) == "number", type(b) == "number"
    if anum == bnum then return a < b else return anum end
  end

  ---Adds a function to the given hook.
  ---
  ---If your function's first return is anything other than nil the hook will end and your
  ---function's return will be the return of the hook.
  ---@param hook_name string
  ---@param identifier string|number
  ---@param func function
  function hook.add(hook_name, identifier, func)
    if type(hook_name) ~= "string" then
      error("bad argument #1 to 'hook.Add' (expected string, got " .. type(hook_name) .. ")", 2)
    elseif type(identifier) ~= "string" and type(identifier) ~= "number" then
      error("bad argument #2 to 'hook.Add' (expected number or string, got " .. type(identifier) .. ")", 2)
    elseif type(func) ~= "function" then
      error("bad argument #3 to 'hook.Add' (expected function, got " .. type(func) .. ")", 2)
    end
    if not hooktable[hook_name] then
      hooktable[hook_name] = {}
      hooktableorder[hook_name] = {}
    end
    hooktable[hook_name][identifier] = func
    hooktableorder[hook_name][#hooktableorder[hook_name]+1] = identifier
    table.sort(hooktableorder[hook_name], sortHookOrder)
  end

  ---Gets the entire hook table.
  ---@return table<string, table<string|number, function>>
  function hook.getTable() return hooktable end

  ---Removes the given identifier from the given hook.
  ---@param hook_name string
  ---@param identifier string|number
  function hook.remove(hook_name, identifier)
    if type(hook_name) ~= "string" then
      error("bad argument #1 to 'hook.Remove' (expected string, got " .. type(hook_name) .. ")", 2)
    elseif type(identifier) ~= "string" and type(identifier) ~= "number" then
      error("bad argument #2 to 'hook.Remove' (expected number or string, got " .. type(identifier) .. ")", 2)
    end
    if not (hooktable[hook_name] and hooktable[hook_name][identifier]) then return end
    hooktable[hook_name][identifier] = nil
    for i,v in ipairs(hooktableorder[hook_name]) do
      if v == identifier then table.remove(hooktableorder[hook_name], i) break end
    end
  end

  ---Runs the given hook with the given variables.
  ---
  ---If one of the functions in the hook returns a non-nil *first* value, the hook will immediately
  ---end and return the first 6 values the function gave.
  ---@param hook_name string
  ---@param ... any
  ---@return any, any?, any?, any?, any?, any?
  function hook.run(hook_name, ...)
    if type(hook_name) ~= "string" then
      error("bad argument #1 to 'hook.Run' (expected string, got " .. type(hook_name) .. ")", 2)
    end
    local hooks = hooktable[hook_name]
    local order = hooktableorder[hook_name]
    if hooks then
      local r1,r2,r3,r4,r5,r6
      for _,f in pairs(order) do
        r1,r2,r3,r4,r5,r6 = hooks[f](...)
        if r1 ~= nil then return r1,r2,r3,r4,r5,r6 end
      end
    end
  end
end
---Lets other scripts know that this has loaded in if they depend on it.
---@diagnostic disable-next-line: unused-local
local LIB_GSHOOK = "0.1.0"
