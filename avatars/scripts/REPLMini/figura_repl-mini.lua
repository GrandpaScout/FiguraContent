if client.isHost() then
  --[[>======================================<< INFO >>======================================<[]--
      FIGURA REPL MINI
      By: GrandpaScout [STEAM_1:0:55009667]
      Version: 1.0.0
      Compatibility: >= Figura 0.0.8
      Description:
        A minified version of the main REPL script.
        This can be better embedded into an avatar for quicker testing.
  --[]>====================================<< END INFO >>====================================<]]--

  local string = {}
  for k,v in pairs(_G.string) do string[k] = v end

  local function checkSMT()
    return (pcall(function()
      ---@diagnostic disable: unused-local, discard-returns, empty-block
      local str, str2, a, b = "%s", "I"
      str:byte(1,3) str:find("h", 1, true) str:format("hello")
      str:gsub("h", "i", 2) str:len() str:lower() str:match("h", 2)
      str:rep(5, "//") str:reverse() str:sub(1, 4) str:upper()
      for _ in str:gmatch("h") do end
      ---@diagnostic enable: unused-local, discard-returns, empty-block
    end))
  end
  if not checkSMT() then local t = {}; for k,f in pairs(string) do t[k] = f end; getmetatable("").__index = t end

  local Infinity = math.huge --An infinite value, for convenience.
  ---@cast Infinity -number #Shut up type hints for this value.
  --[========================================[ CONFIG ]========================================]--

  local repl_config = {
    boolean = {
      --[[true symbol     | string ]] true_char   = "☑",
      --[[false symbol    | string ]] false_char  = "☒"
    },
    number = {
      --[[0x, 0X, #, etc. | string ]] hex_prefix = "0x"
    },
    string = {
      --[[= "hello wo..." | number ]] value_size  = 256,
      --[["hello worl..." | number ]] max_size    = Infinity,
      --[["\0" -> "∅"     | boolean]] use_symbols = true
    },
    table = {
      --[[["string"] =    | number ]] skey_len    = 16,
      --[[max table depth | number ]] max_indent  = 1,
      --[[max table len   | number ]] max_length  = Infinity
    }
  }

  --[======================================[ END CONFIG ]======================================]--

  local replcatmt = {
    __metatable = false,
    __newindex = function(self, k, v)
      if self[k] == nil then error("cannot change non-existent Config Setting") end
      rawset(self, k, type(v) == "string" and v:gsub("([\\\"])", "\\%1") or v)
    end,
    __index = {NewSetting = function(self, k, v) if self[k] ~= nil then rawset(self, k, v or false) end end}
  }
  for _,c in pairs(repl_config) do setmetatable(c, replcatmt) end
  setmetatable(repl_config, {
    __metatable = false,
    __newindex = function(self, k) error("cannot " .. (self[k] and "replace" or "add new") .. " Config Setting category") end,
    __index = {NewCategory = function(self, k) if not self[k] then rawset(self, k, setmetatable({}, replcatmt)) end end}
  })

  local rcb, rcn, rcs, rct = repl_config.boolean, repl_config.number, repl_config.string, repl_config.table
  local strrep = {
    all = '([\0\a\b\f\n\r\t\v\\"])', fmt = "\1\255fmt(%d+)\1",
    ["\0"] = {"0", "∅"}, ["\a"] = {"a", "♪"}, ["\b"] = {"b", "←"}, ["\f"] = {"f", "⊻"},
    ["\n"] = {"n", "↓"}, ["\r"] = {"r", "⏮"}, ["\t"] = {"t", "⇄"}, ["\v"] = {"v", "⇵"},
    ["\\"] = {"\\", "\\"}, ["\""] = {'"', '"'}
  }

  function strrep.toStr(x) return "§8\\§4" .. strrep[x][1] .. "§c" end
  function strrep.toSym(x) return "§4" .. strrep[x][2] .. "§c" end
  strrep.fmts = {}
  function strrep.storeFmt(x) local fmts = strrep.fmts; fmts[#fmts+1] = x; return ("\1\255fmt%d\1"):format(#fmts) end
  function strrep.loadFmt(x) x = tonumber(x); local fmt = strrep.fmts[x]; return fmt and ("§4ƒ§%s%s§c"):format(fmt,fmt) or "" end
  function strrep.clearFmts() if #strrep.fmts ~= 0 then strrep.fmts = {} end end

  local keyrank = {boolean = 0, number = 1, string = 2, table = 3, ["function"] = 4, thread = 5, vector = 6, userdata = 7, other = 99}

  local function tblsort(a, b)
    local ar, br = keyrank[type(a)] or keyrank.other, keyrank[type(b)] or keyrank.other
    if ar == br then if ar == 1 then return a < b else return tostring(a) < tostring(b) end else return ar < br end
  end

  local figuraFIDs = {PingFunction = true}
  local threadstatus = {running = "", suspended = "§6", normal = "§3", dead = "§4"}

  local Format = {} do
    Format = {
      any = function(x, detail, options)
        options = options or {}
        local t = type(x)
        if t == "string" then return Format.string(x, detail, options.length)
        elseif t == "table" then return Format.table(x, detail, options.indent, options.length, options.DONE)
        elseif t == "vector" then return Format.vector(x, detail, options.max)
        else return (Format[t] or Format.other)(x, detail) end
      end,
      ["nil"] = function() return "§7nil" end,
      boolean = function(x, detail)
        local str = x and "§etrue" or "§efalse"
        if detail then str = str .. (x and (" §2" .. rcb.true_char) or (" §4" .. rcb.false_char)) end
        return str
      end,
      number = function(x, detail)
        local ax, str = math.abs(x), "§9" .. x
        if detail and math.floor(x) == x and ax <= 0x7FFFFFFFFFFFFFFF then str = str .. (" §1(%s%s%X)"):format((x < 0 and "-" or ""), rcn.hex_prefix, ax) end
        return str
      end,
      string = function(x, detail, length)
        length = tonumber(length); local xstr
        if not length or (length <= 0) or (length >= #x) then xstr, length = x, false else xstr = x:sub(1, length-4) end

        local toF = rcs.use_symbols and strrep.toSym or strrep.toStr
        local str = xstr:gsub("§(.)", strrep.storeFmt):gsub(strrep.all, toF):gsub(strrep.fmt, strrep.loadFmt):gsub("§$", "§4ƒ§c", 1)
        strrep.clearFmts()

        return ('§c"%s%s"%s'):format(str, length and " §7· · · §c" or "", detail and (" §4(%d byte%s)"):format(#x, #x ~= 1 and "s" or "") or "")
      end,
      table = function(x, detail, indent, length, DONE)
        local contents;
        if indent == false then contents = false else indent = math.max(tonumber(indent) or 1, 1); contents = indent <= rct.max_indent end

        local xlen = 0
        if detail then
          for _ in pairs(x) do xlen = xlen + 1 end --Iterate the table for *every* key to get the real size.
          if xlen == 0 then local s, r = pcall(function() return #x end); xlen = s and tonumber(r) or 0 end
        end

        if contents and next(x) == nil then
          return ("§b%s §8{%s§8}"):format(tostring(x), detail and (" §3(%d index%s) "):format(xlen, xlen ~= 1 and "es" or "") or "")
        end

        local str = ("§b%s%s%s"):format(
          tostring(x), contents and " §8{" or "", detail and (" §3(%d index%s)"):format(xlen, xlen ~= 1 and "es" or "") or ""
        )

        if not DONE then DONE = {root = x, [x] = true}
        elseif DONE.root == x then str = str .. " §f<ROOT>"
        elseif DONE[x] then str = str .. " §b<DUPE>"
        else DONE[x] = true end

        if contents then
          local keys = {}; for k in pairs(x) do keys[#keys+1] = k end; table.sort(keys, tblsort)

          local strs, spaces = {}, ("  "):rep(indent)
          for i,k in ipairs(keys) do
            local v = x[k]
            strs[#strs+1] = ("\n%s§8[%s§8] = %s"):format(
              spaces,
              Format.any(k, false, {length = rct.skey_len, indent = false, max = false}),
              Format.any(v, true, {
                indent = not DONE[v] and (indent+1) or false, length = type(v) == "string" and rcs.value_size or rct.max_length, DONE = DONE
              })
            )
            if length and (i >= length) and (#keys > i) then strs[#strs+1] = ("  · · ·  (%d more)"):format(#keys - i) break end
          end
          str = str .. ("%s\n%s§8}"):format(table.concat(strs, ""), ("  "):rep(indent-1))
        end
        return str
      end,
      ["function"] = function(x, detail)
        local str, s, dump = "§dfunction: ", pcall(string.dump, x)
        if s then
          local fname, flines = tostring(x):match("^function: ([^:]+)(:%d+%-%d+)$")
          return str .. ("§5%s§8%s%s"):format(fname:gsub("§r", "§5"), flines, detail and (" §5(%d byte%s)"):format(#dump, #dump ~= 1 and "s" or "") or "")
        else
          local fid = tostring(x):match(" ?([%w_]+)$")
          local ftype = fid and ((tonumber(fid) or figuraFIDs[fid]) and "figura" or "builtin") or "unknown"
          return str .. ("§8%s:§d%s%s"):format(ftype, fid or "<NAME ERROR>", detail and " §6(JAVA)" or "")
        end
      end,
      userdata = function(x) local ustr = tostring(x); return "§7userdata: " .. ustr:gsub("^userdata: ", "", 1) end,
      thread = function(x, detail)
        local status = detail and coroutine.status(x)
        return ("§a%s%s"):format(tostring(x), detail and (" §2(%s%s§2)"):format(threadstatus[status], status) or "")
      end,
      vector = function (x, detail, max)
        max = max == nil or max
        local i = 1
        for j=6,1,-1 do if x[j] ~= 0 then i = j break end end
        local strs = {}
        if max then
          for j=1,i do strs[#strs+1] = tostring(x[j]) end
        else
          for j=1,i do
            local fstr = tostring(x[j])
            local fsub = fstr:sub(1, (fstr:find("%..*$") or #fstr) + 5)
            strs[#strs+1] = fsub .. ((#fstr > #fsub) and "..." or "")
          end
        end

        return ("§8<§f%s§8>%s"):format(table.concat(strs, "§8,§f"), detail and (" §7(" .. i .. "/6 indexes)") or "")
      end,
      other = function(x, detail) return ("§f%s%s"):format(tostring(x), detail and (" §7(" .. type(x) .. ")") or "") end
    }
  end

  REPL = {
    _mini = true, stringify = Format, config = repl_config, bound = false, keyWP = false,
    key = keybind.newKey("[REPL] Bind to Chat", "GRAVE_ACCENT"),
    log = function(x, detail, options) options = options or {}; log(Format.any(x, detail, options), false) end
  }
  local REPL = REPL

  local REPLmt = {
    __call = function(self, cmd)
      if cmd ~= nil then
        cmd = tostring(cmd)
        if cmd:sub(1,1) == "/" then
          log("§fREPL: Ignoring Minecraft command.", false)
          ---@diagnostic disable-next-line: missing-parameter
          chat.setFiguraCommandPrefix(); chat.sendMessage(cmd); chat.setFiguraCommandPrefix("")
          return
        end
      else
        cmd = ""
      end
      ---@diagnostic disable-next-line: missing-parameter
      chat.setFiguraCommandPrefix()
      ---@diagnostic disable-next-line: deprecated
      local f = loadstring("return " .. cmd)
      if type(f) == "function" then log("§fINPUT:\n§dreturn §f" .. cmd, false)
      else
        ---@diagnostic disable-next-line: deprecated
        f = loadstring(cmd)
        if type(f) == "function" then log("§fINPUT:\n§f" .. cmd, false)
        else log("§cREPL: Compile Error!\n" .. f:gsub("\t", "  "), false) chat.setFiguraCommandPrefix(""); return end
      end

      local r = {pcall(f)}
      if not r[1] then
        log("§cREPL: Runtime Error!\n" .. r[2]:gsub("\t", "  "):gsub("§.", ""), false)
        chat.setFiguraCommandPrefix(""); return
      end
      table.remove(r, 1)

      local rh = 0; for i in pairs(r) do if i > rh then rh = i end end
      for i = 1, rh do
        local v = r[i]
        r[i] = Format.any(v, true, {
          indent = rct.max_indent < 0 and rct.max_indent or nil, length = type(v) == "string" and rcs.max_size or rct.max_length
        })
      end
      if rh == 0 then r[1] = Format["nil"]() .. " §8(no value?)" end
      log("§fRETURNS:\n" .. table.concat(r, "\n") .. "\n", false)
      chat.setFiguraCommandPrefix("")
    end
  }

  REPLINSTANCE_Biome, REPLINSTANCE_BlockState, REPLINSTANCE_ItemStack, REPLINSTANCE_FiguraKeybind, REPLINSTANCE_RegisteredKeybind, REPLINSTANCE_Vector =
  biome.getBiome("minecraft:plains", {}), block_state.createBlock("minecraft:chest"), item_stack.createItem("minecraft:shield"),
  keybind.newKey("[REPL] <INTERNAL USE>", "UNKNOWN"), keybind.getRegisteredKeybind("key.jump"), vectors.of{1,2,3,4,5,6}

  local vec = REPLINSTANCE_Vector
  vectors.methods = {
    vec.asTable,vec.toDeg,vec.toRad,vec.angleTo,vec.cross,vec.dot,vec.normalized,vec.getLength,vec.distanceTo
  }

  function mtof(x) return getmetatable(x) end
  function keysof(x)
    if type(x) ~= "table" then error("bad argument to 'keysof' (table expected, got " .. type(x) .. ")") end
    local keys = {}; for k in pairs(x) do keys[#keys+1] = k end; table.sort(keys, tblsort)
    return keys
  end
  local log256 = math.log(256)
  local sizefunc = {
    default = 0, ["nil"] = 0, boolean = 1, string = function(x) return #x end,
    number = function(x) return math.floor(math.log(x) / log256)+1 end,
    table = function(x) local keys = {} for k in pairs(x) do keys[#keys+1] = k end return #keys end,
    ["function"] = function(x) local s, r = pcall(string.dump, x) return s and #r or 0 end
  }
  function sizeof(x) local t = type(x) --[[@type string]]; local f = sizefunc[t]; return type(f) == "function" and f(x) or f end
  function colorof(x)
    if type(x) ~= "vector" then error("bad argument to 'colorof' (vector expected, got " .. type(x) .. ")") end
    local hex = ("%06X"):format(vectors.rgbToINT(x))
    if x.x > 1 or x.x < 0 or x.y > 1 or x.y < 0 or x.z > 1 or x.z < 0 then return false end
    log('{"text":"Lorem_Ipsum █ ⏹⏺◆","color":"#' .. hex .. '","italic":false}', true)
    return {tonumber(hex:sub(1,2),16), tonumber(hex:sub(3,4),16), tonumber(hex:sub(5,6),16)}
  end
  function sync(x) if #x > 0 then ping.REPLSync(x) end end

  REPL.testtable = {
    [true] = 123.456, [123.456] = "\abcxyz", ["qwer\ty"] = {"hello", "world", {"!"}},
    [{"foo","bar","baz",yalike="jazz?"}] = vectors.of{1,2,3,4,5,math.sqrt(2)},
    [vectors.of{1,2,3,4,5,math.sqrt(2)}] = REPLINSTANCE_BlockState["figura$block_state"],
    [REPLINSTANCE_ItemStack["figura$item_stack"]] = false
  }

  setmetatable(REPL, REPLmt)

  onCommand = function(cmd)
    if REPL.bound then
      local s, e = pcall(REPLmt.__call, nil, cmd)
      if not s then
        --We have to assume the worst.
        log("§cREPL: Critical REPL error!\n" .. string.gsub(string.gsub(e, "\t", "  "), "§.", ""), false)

        if not checkSMT() then
          log("\n§4The string metatable has been tampered with!\nCore REPL functions cannot run without a valid string metatable!\nRestart the REPL to attempt to fix this.\n\n§6The REPL has automatically closed due to this error.", false)
          ---@diagnostic disable-next-line: missing-parameter
          chat.setFiguraCommandPrefix(); REPL.bound = false; return
        end
        chat.setFiguraCommandPrefix("")
      end
    end
  end

  function tick()
    local REPLkeyIP = REPL.key.isPressed()
    if REPLkeyIP and not REPL.keyWP then
      ---@diagnostic disable-next-line: missing-parameter
      if REPL.bound then REPL.bound = false; chat.setFiguraCommandPrefix(); log("§fREPL: Unbound from chat.", false)
      else
        REPL.bound = true; chat.setFiguraCommandPrefix(""); log("§fREPL: Bound to chat.", false)
        if not checkSMT() then
          log("§eFixing string metatable...", false)
          local t = {}; for k,f in pairs(string) do t[k] = f end; getmetatable("").__index = t
          if not checkSMT() then
            log("§4\nThe string metatable cannot be repaired. Reload your avatar.\nIf you continue to have issues, restart your game.\n\n§6The REPL will not open until the error is fixed.")
            ---@diagnostic disable-next-line: missing-parameter
            REPL.bound = false; chat.setFiguraCommandPrefix()
          end
        end
      end
    end
    REPL.keyWP = REPLkeyIP
  end

end

function ping.REPLSync(ccmd)
  ---@diagnostic disable-next-line: deprecated
  local f = loadstring("return " .. ccmd)
  ---@diagnostic disable-next-line: deprecated
  if type(f) ~= "function" then f = loadstring(ccmd); if type(f) ~= "function" then log("REPLSync Compile error:\n" .. f) return end end
  local s, r = pcall(f); if not s then log("REPLSync Runtime Error:\n" .. r); return end
end
