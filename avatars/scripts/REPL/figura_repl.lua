if client.isHost() then
  local loadSecrets = true --Disable this if the REPL is slow to load.
  --[[>======================================<< INFO >>======================================<[]--
      FIGURA REPL
      By: GrandpaScout [STEAM_1:0:55009667]
      Version: 4.1.4
      Compatibility: >= Figura 0.0.8
      Description:
        A REPL for use in Figura 0.0.8 or later.
        Contains formatting for types, table printing, hover data, and many other tools.
        It is also themeable!
  --[]>====================================<< END INFO >>====================================<]]--

  --Create a completely seperated string table.
  local string = {}
  for k,v in pairs(_G.string) do
    string[k] = v
  end

  local function checkSMT()
    return pcall(function()
      ---@diagnostic disable: unused-local, discard-returns, empty-block
      local str, str2 = "%s", "I"
      str:byte(1,3) str:find("h", 1, true) str:format("hello")
      str:gsub("h", "i", 2) str:len() str:lower() str:match("h", 2)
      str:rep(5, "//") str:reverse() str:sub(1, 4) str:upper()
      for _ in str:gmatch("h") do end
      ---@diagnostic enable: unused-local, discard-returns, empty-block
    end)
  end
  --The REPL *requires* a functional string metatable.
  --This will replace a missing one with a substitute.
  if not checkSMT() then
    local t = {}
    for k,f in pairs(string) do t[k] = f end
    getmetatable("").__index = t
  end

  ---@type any #Shut up type hints for this value.
  local Infinity = math.huge --An infinite value, for convenience.
  --[=========================================[ CONFIG ]=========================================]--

  local repl_theme = {
    repl = { --Generic REPL text
      --[[Normal text.    | color  ]] default     = "white",
      --[[INPUT:          | color  ]] input       = "white",
      --[[RETURNS:        | color  ]] returns     = "white",
      --[[REPL: Notice    | color  ]] notice      = "white",
      --[[REPL: Error     | color  ]] error       = "red",
      --[[return          | color  ]] repl_return = "light_purple",
      --[[User Code.      | color  ]] user_input  = "white",
    },
    any = { -- Any values
      --[[Prop:           | color  ]] h_property  = "dark_gray",
      --[[Metatable: {}   | number ]] meta_len    = 16
    },
    null = { -- Nil values
      --[[nil             | color  ]] default     = "gray",
      --[[(no value?)     | color  ]] no_value    = "dark_gray"
    },
    boolean = { -- Booleans
      --[[true false      | color  ]] default     = "yellow",
      --[[true color      | color  ]] t           = "dark_green",
      --[[false color     | color  ]] f           = "dark_red",
      --[[true symbol     | string ]] true_char   = "☑",
      --[[false symbol    | string ]] false_char  = "☒"
    },
    number = { -- Numbers
      --[[123             | color  ]] default     = "blue",
      --[[(0x7B)          | color  ]] hex         = "dark_blue",
      --[[0b10            | color  ]] bin         = "dark_blue",
      --[[0o71            | color  ]] oct         = "dark_blue",
      --[[0x, 0X, #, etc. | string ]] hex_prefix  = "0x",
      --[[0b, 0B, etc.    | string ]] bin_prefix  = "0b",
      --[[0o, 0O, 0, etc. | string ]] oct_prefix  = "0o"
    },
    string = { -- Strings
      --[["abc"           | color  ]] default     = "red",
      --[[\r\n§           | color  ]] escaped     = "dark_red",
      --[[\               | color  ]] slash       = "dark_gray",
      --[[(# bytes)       | color  ]] bytes       = "dark_red",
      --[[# characters    | color  ]] characters  = "dark_red",
      --[[...             | color  ]] len_limit   = "gray",
      --[[= "hello wo..." | number ]] value_size  = 256,
      --[["hello worl..." | number ]] max_size    = Infinity,
      --[["Hover Da..."   | number ]] max_h_size  = 4096,
      --[[\0 -> ∅         | boolean]] use_symbols = true
    },
    table = { -- Tables
      --[[table: 1234abcd | color  ]] default     = "aqua",
      --[[(# indexes)     | color  ]] indexes     = "dark_aqua",
      --[[{ }             | color  ]] bracket     = "dark_gray",
      --[[[ ]             | color  ]] key_bracket = "dark_gray",
      --[[=               | color  ]] equals      = "dark_gray",
      --[[ · · · (# more) | color  ]] line_limit  = "gray",
      --[[<ROOT>          | color  ]] root        = "white",
      --[[<DUPE>          | color  ]] duplicate   = "aqua",
      --[[["string"] =    | number ]] skey_len    = 16,
      --[[max table depth | number ]] max_indent  = 1,
      --[[max table len   | number ]] max_length  = Infinity,
      --[[ · · · }        | number ]] more_len    = 48,
      --[[Contents: {}    | number ]] content_len = 32
    },
    func = { -- Functions
      --[[function:       | color  ]] default     = "light_purple",
      --[[avatar          | color  ]] script      = "dark_purple",
      --[[:123-167        | color  ]] lines       = "dark_gray",
      --[[builtin:        | color  ]] builtin     = "dark_gray",
      --[[figura:         | color  ]] figura      = "dark_gray",
      --[[unknown:        | color  ]] unknown     = "dark_gray",
      --[[(# bytes)       | color  ]] bytes       = "dark_purple",
      --[[Lua             | color  ]] lua         = "blue",
      --[[(JAVA)          | color  ]] java        = "gold"
    },
    userdata = {
      --[[userdata:       | color  ]] default     = "gray",
      --[[1 stick         | color  ]] value       = "gray"
    },
    thread = { -- Threads
      --[[thread: 1234abc | color  ]] default     = "green",
      --[[(status)        | color  ]] parentheses = "dark_green",
      --[[Running         | color  ]] running     = "green",
      --[[Suspended       | color  ]] suspended   = "gold",
      --[[Normal          | color  ]] normal      = "dark_aqua",
      --[[Dead            | color  ]] dead        = "dark_red"
    },
    vector = { -- Vectors
      --[[1.23            | color  ]] default     = "white",
      --[[< >             | color  ]] bracket     = "dark_gray",
      --[[,               | color  ]] seperator   = "dark_gray",
      --[[(#/6 indexes)   | color  ]] indexes     = "gray",
      --[[123.45          | color  ]] length      = "gray",
    },
    other = { -- Unknown types.
      --[[stringified val | color  ]] default     = "white",
      --[[(type)          | color  ]] type        = "gray"
    }
  }
  --[=======================================[ END CONFIG ]=======================================]--

  local replcatmt = {
    __metatable = false,
    __newindex = function(self, key, value)
      if self[key] == nil then error("cannot change non-existent Theme Setting") end
      if type(value) == "string" then
        rawset(self, key, value:gsub("([\\\"])", "\\%1"))
      else
        rawset(self, key, value)
      end
    end,
    __index = {
      NewSetting = function(self, name, value)
        if self[name] ~= nil then
          rawset(self, name, value or false)
        end
      end
    }
  }

  for _,c in pairs(repl_theme) do
    setmetatable(c, replcatmt)
  end

  setmetatable(repl_theme, {
    __metatable = false,
    __newindex = function(self, key)
      if not self[key] then
        error("cannot add new Theme Setting category")
      else
        error("cannot replace Theme Setting category")
      end
    end,
    __index = {
      NewCategory = function(self, name)
        if not self[name] then
          rawset(self, name, setmetatable({}, replcatmt))
        end
      end
    }
  })

  local
    rtr, rta, rtx,
    rtb, rtn, rts,
    rtt, rtf, rtu,
    rtc, rtv, rto
      =
    repl_theme.repl, repl_theme.any, repl_theme.null,
    repl_theme.boolean, repl_theme.number, repl_theme.string,
    repl_theme.table, repl_theme.func, repl_theme.userdata,
    repl_theme.thread, repl_theme.vector, repl_theme.other

  local strrep = {
    all    = '([\0\a\b\f\n\r\t\v\\"])', --∅♪←⊻↓⏮⇄⇵
    ["\0"] = {"0", "∅"},
    ["\a"] = {"a", "♪"},
    ["\b"] = {"b", "←"},
    ["\f"] = {"f", "⊻"},
    ["\n"] = {"n", "↓"},
    ["\r"] = {"r", "⏮"},
    ["\t"] = {"t", "⇄"},
    ["\v"] = {"v", "⇵"},
    ["\\"] = {"\\\\", "\\\\"},
    ["\""] = {'\\"', '\\"'}
  }

  function strrep.toStr(x)
    return ('",{"text":"\\\\","color":"%s"},{"text":"%s","color":"%s"},"'):format(
      rts.slash,
      strrep[x][1],
      rts.escaped
    )
  end

  function strrep.toSym(x)
    return ('",{"text":"%s","color":"%s"},"'):format(
      strrep[x][2],
      rts.escaped
    )
  end

  local keyrank = {
    boolean = 0, number = 1, string = 2, table = 3,
    ["function"] = 4, thread = 5, vector = 6, userdata = 7, other = 99
  }

  local function tblsort(a, b)
    local ar, br = keyrank[type(a)] or keyrank.other, keyrank[type(b)] or keyrank.other
    if ar == br then
      if ar == 1 then
        return a < b
      else
        return tostring(a) < tostring(b)
      end
    else
      return ar < br
    end
  end

  local figuraFIDs = {
    PingFunction = true
  }

  H = {}
  local H = H
  setmetatable(H, {
    __pow = function(self, ind)
      if self ~= H then
        error("index from the right side of the history list")
      elseif type(ind) ~= "number" then
        error("quick-history only works with a number")
      else
        local x,y = tostring(ind):match("^(%-?%d*)%.?(%d-)$")
        x,y = tonumber(x) or 1, tonumber(y)
        local res = self[x == 0 and 1 or #self-x+1]
        return res and (y and res[y] or res) or nil
      end
    end
  })

  O = {}
  local O = O
  local Otypes = {number = true, ["function"] = true, table = true, userdata = true, thread = true, vector = true}
  local Omt = {
    __type = "PointersList",
    __index = {
      N = {},
      Nindex = {}
    }
  }
  local Oindex, OindexN, OindexNi = Omt.__index, Omt.__index.N, Omt.__index.Nindex
  function Omt:__newindex(key)
    local t = type(key)
    if Otypes[t] then
      if t == "number" then
        if not OindexNi[key] then
          OindexN[#Oindex.N+1] = key
          OindexNi[key] = #Oindex.N
        end
      elseif not Oindex[key] then
        Oindex[#Oindex+1] = key
        Oindex[key] = #Oindex
      end
    end
  end
  function Omt:__len() return #Oindex end
  setmetatable(O, Omt)

  local JSON = {} do
    local function PointersListHover(x, hasContents)
      local xmt = getmetatable(x).__index
      local str = ('{"text":"PointerList","color":"%s"},{"text":" (table)\n","color":"%s"},[{"text":"Pointers: ","color":"%s"},{"text":"%d","color":"%s"}'):format(
        rtt.default,
        rtt.indexes,
        rta.h_property,
        #xmt, rtt.indexes
      )
      if not hasContents then
        str = str .. ',"\n\nContents: "' .. JSON.stringify.custom.PointersList(x, true, true, {
          length = rtt.content_len, indent = "single"
        })
      end
      return ('{"action":"show_text","value":[%s]]}'):format(str)
    end

    local function PointersListMoreHover(x, tbl, i)
      local strs = {
        ('{"text":"    · · ·","color":"%s"}'):format(rtt.line_limit)
      }
      for j = i+1, #tbl do
        local v = x[j]
        strs[#strs+1] = (',"\n  "%s,{"text":" = ","color":"%s"}%s'):format(
          JSON.stringify.number(j, false, true),
          rtt.equals,
          JSON.stringify.any(v, true, true, {indent = false})
        )
        if j >= (i+rtt.more_len) and j ~= #tbl then
          strs[#strs+1] = (',{"text":"\n    · · ·  (%d more)","color":"%s"}'):format(
            #tbl - j, rtt.line_limit
          )
          break
        end
      end
      return ('{"action":"show_text","value":[%s,{"text":"\n]","color":"%s"}]}'):format(
        table.concat(strs), rtt.bracket
      )
    end

    local function HistoryHover(x, hasContents)
      --Not yet.
    end

    JSON.stringify = {
      ---@type table<string, fun(x: table, detail: boolean, inHover: boolean, options: {indent?:number|"false", DONE?: table, length?: number, max?: boolean}): string>
      custom={
        ---@param x table
        ---@param detail? string
        ---@param inHover? boolean
        ---@param options? {indent?:number|"false", DONE?: table, length?: number, max?: boolean}
        PointersList = function(x, detail, inHover, options)
          local xmt = getmetatable(x).__index
          local indent
          options = options or {}
          if options.indent == false then
            indent = rtt.max_indent + 1
          else
            indent = tonumber(options.indent) and math.max(options.indent, 0) or 1
          end
          local contents = indent <= rtt.max_indent
          local str = (',[{"text":"PointerList: %s","color":"%s"%s}'):format(
            tostring(x):match("^table: (%x%x?%x?%x?%x?%x?%x?%x?)$") or "???",
            rtt.default,
            not inHover and (',"insertion":"O","hoverEvent":' .. PointersListHover(x, contents)) or ""
          )
          if contents then str = str .. (',[{"text":" [","color":"%s"}'):format(rtt.bracket) end
          if detail then
            str = str .. (',{"text":" (%d pointers)","color":"%s"}'):format(
              #xmt, rtt.indexes
            )
          end
          if contents then
            local strs = {}
            for i,v in ipairs(xmt) do
              strs[#strs+1] = (',"\n%s"%s,{"text":" = ","color":"%s"}%s'):format(
                ("  "):rep(indent),
                JSON.stringify.number(i, false, inHover),
                rtt.equals,
                JSON.stringify.any(v, true, inHover, {indent = false})
              )
              if options.length and (i >= options.length) and ((#xmt - i) ~= 0) then
                if inHover then
                  strs[#strs+1] = (',{"text":"\n%s  · · ·  (%d more)","color":"%s"}'):format(
                    ("  "):rep(indent), #xmt - i, rtt.line_limit
                  )
                else
                  strs[#strs+1] = (',{"text":"\n%s  · · ·  (%d more)","color":"%s","hoverEvent":%s}'):format(
                    ("  "):rep(indent), #xmt - i, rtt.line_limit, PointersListMoreHover(x, Oindex, i)
                  )
                end
                break
              end
            end
            str = str .. ('%s,"\n%s]"]'):format(
              table.concat(strs), ("  "):rep(math.max(indent-1, 0))
            )
          end
          return str .. "]"
        end
      },

      ---@param x any
      ---@param detail? string
      ---@param inHover? boolean
      ---@param options? {indent?:number|"false", DONE?: table, length?: number, max?: boolean}
      ---@return string
      any = function(x, detail, inHover, options)
        options = options or {}
        local t = type(x)
        if t == "string" then
          return JSON.stringify.string(x, detail, inHover, options.length)
        elseif t == "table" then
          local mt = getmetatable(x)
          local mtt = type(mt) == "table" and mt.__type or nil
          if mtt and JSON.stringify.custom[mtt] then
            return JSON.stringify.custom[mtt](x, detail, inHover, options)
          else
            return JSON.stringify.table(x, detail, inHover, options.indent, options.length, options.DONE)
          end
        elseif t == "vector" then
          return JSON.stringify.vector(x, detail, inHover, options.max)
        else
          return (JSON.stringify[t] or JSON.stringify.other)(x, detail, inHover)
        end
      end,
      ---@param inHover? boolean
      ---@return string
      ["nil"] = function(_, _, inHover)
        return (',{"text":"nil","color":"%s"%s}'):format(
          rtx.default,
          not inHover and (',"insertion":"nil","hoverEvent":%s'):format(JSON.hoverData["nil"]()) or ""
        )
      end,
      ---@param x boolean
      ---@param detail? boolean
      ---@param inHover? boolean
      ---@return string
      boolean = function(x, detail, inHover)
        local str = (',[{"text":"%s","color":"%s"%s}'):format(
          tostring(x), rtb.default,
          not inHover and (',"insertion":"%s","hoverEvent":%s'):format(
            tostring(x), JSON.hoverData.boolean(x)
          ) or ""
        )
        if detail then
          str = str .. (',{"text":" %s","color":"%s"}'):format(
            x and rtb.true_char or rtb.false_char,
            x and rtb.t or rtb.f
          )
        end
        return str .. "]"
      end,
      ---@param x number
      ---@param detail? boolean
      ---@param inHover? boolean
      ---@return string
      number = function(x, detail, inHover)
        local unsafenum = tonumber(tostring(x)) ~= x
        local insert = x
        if unsafenum and not O.Nindex[x] then
          O[x] = true
          if not inHover then insert = "O.N[" .. O.Nindex[x] .. "]" end
        end
        local str = (',[{"text":"%s","color":"%s"%s}'):format(
          tostring(x), rtn.default,
          not inHover and (',"insertion":"%s","hoverEvent":%s'):format(
            insert, JSON.hoverData.number(x)
          ) or ""
        )
        if detail and math.floor(x) == x and x-1 ~= x then
          str = str .. (',{"text":" (%s%X)","color":"%s"}'):format(
            rtn.hex_prefix, x, rtn.hex
          )
        end
        return str .. "]"
      end,
      ---@param x string
      ---@param detail? boolean
      ---@param inHover? boolean
      ---@param length? number
      ---@return string
      string = function(x, detail, inHover, length)
        length = tonumber(length)
        local xstr
        if not length or (length <= 0) or (length >= #x) then
          xstr = x
          length = false
        else
          xstr = x:sub(1, length-4)
        end

        local firstmatch = xstr:find(strrep.all) or xstr:find("§")
        local str
        if firstmatch then
          str = xstr
            :gsub(
              strrep.all,
              rts.use_symbols and strrep.toSym or strrep.toStr
            )
            :gsub(
              "§(.)",
              ('",{"text":"ƒ","color":"%s"},"§%%1%%1§r'):format(rts.escaped)
            )
          str = (',[{"text":"\\"%s","color":"%s"%s}'):format(
            str:sub(1, firstmatch-1), rts.default,
            not inHover and (',"insertion":"\\"%s\\"","hoverEvent":%s'):format(
              x
                :gsub(strrep.all, function(c) return "\\\\" .. strrep[c][1] end)
                :gsub("§", "\\\\xC2\\\\xA7")
                :gsub("([\1\2\3\4\5\6\14\15\16\17\18\19\20\21\22\23\24\25\26\27\28\29\30\31\127])", function(c) return "\\\\" .. string.byte(c) end),
              JSON.hoverData.string(x)
            ) or ""
          ) .. str:sub(firstmatch+1)
          if str:find(',"$') then
            str = str:sub(1, -3) .. (length and (',{"text":" · · · ","color":"%s"},"\\""'):format(rts.len_limit) or ',"\\""')
          else
            str = str .. (length and ('",{"text":" · · · ","color":"%s"},"\\""'):format(rts.len_limit) or '\\""')
          end
        else
          str = (',[{"text":"\\"%s","color":"%s"%s}%s,"\\""'):format(
            xstr, rts.default,
            not inHover and (',"insertion":"\\"%s\\"","hoverEvent":%s'):format(
              x
                :gsub(strrep.all, function(c) return "\\\\" .. strrep[c][1] end)
                :gsub("§", "\\\\xC2\\\\xA7")
                :gsub("([\1\2\3\4\5\6\14\15\16\17\18\19\20\21\22\23\24\25\26\27\28\29\30\31\127])", function(c) return "\\\\" .. string.byte(c) end),
              JSON.hoverData.string(x)
            ) or "",
            length and (',{"text":" · · · ","color":"%s"}'):format(rts.len_limit) or ""
          )
        end
        if detail then
          str = str .. (',{"text":" (%d byte%s)","color":"%s"}'):format(
            #x, #x ~= 1 and "s" or "", rts.bytes
          )
        end
        return str .. "]"
      end,
      ---@param x table
      ---@param detail? boolean
      ---@param inHover? boolean
      ---@param indent? "false"|number|'"single"'
      ---@param length? number
      ---@param DONE? table
      ---@return string
      table = function(x, detail, inHover, indent, length, DONE)
        local noindent
        if indent == false then
          indent = rtt.max_indent + 1
        elseif indent == "single" then
          noindent = true
          indent = 1
        end
        indent = indent == nil and 1 or math.max(indent, 0)
        if not O[x] then O[x] = true end
        local insert = "O[" .. O[x] .. "]"
        local contents = indent <= rtt.max_indent
        local xlen = 0
        if not inHover or detail then
          for _ in pairs(x) do --Iterate the table for *every* key to get the real size.
            xlen = xlen + 1
          end
          if xlen == 0 then --If a table cannot be iterated, try getting the length. If that fails, use 0.
            local s, r = pcall(function() return #x end)
            xlen = s and tonumber(r) or 0
          end
        end
        local str = (',[{"text":"%s","color":"%s"%s}'):format(
          tostring(x), rtt.default,
          not inHover and (',"insertion":"%s","hoverEvent":%s'):format(
            insert, JSON.hoverData.table(x, contents, xlen)
          ) or ""
        )
        if contents then str = str .. (',{"text":" {","color":"%s"}'):format(rtt.bracket) end
        if detail then
          str = str .. (',{"text":" (%d index%s)","color":"%s"}'):format(
            xlen, xlen ~= 1 and "es" or "", rtt.indexes
          )
        end
        if contents and next(x) == nil then
          str = str .. (',{"text":"%s}","color":"%s"}'):format(
            detail and " " or "",
            rtt.bracket
          )
          contents = false
        end
        str = str .. "]"
        if not DONE then --DONE handles recursion.
          DONE = {}
          DONE.root = x
          DONE[x] = true
        elseif DONE.root == x then
          str = str .. (',{"text":" <ROOT>","color":"%s"}'):format(rtt.root)
        elseif DONE[x] then
          str = str .. (',{"text":" <DUPE>","color":"%s"}'):format(rtt.duplicate)
        else
          DONE[x] = true
        end
        if contents then
          local keys = {}
          for k in pairs(x) do --Get all keys and sort them.
            keys[#keys+1] = k
          end
          table.sort(keys, tblsort)

          local strs = {}
          for i,k in ipairs(keys) do
            local v = x[k]
            strs[#strs+1] = (',[{"text":"\n%s[","color":"%s"}%s,"]"],{"text":" = ","color":"%s"}%s'):format(
              noindent and "  " or (" "):rep(indent*2), rtt.key_bracket,
              JSON.stringify.any(k, false, inHover, {
                length = rtt.skey_len, indent = false, max = false
              }),
              rtt.equals,
              JSON.stringify.any(v, true, inHover, {
                indent = ((not DONE[v] and not noindent) and (indent + 1) or false),
                length = type(v) == "string" and rts.value_size or rtt.max_length,
                DONE = DONE
              })
            )
            if length and (i >= length) and (#keys > i) then --If the line limit is hit, stop the table early.
              if inHover then
                strs[#strs+1] = (',{"text":"\n%s  · · ·  (%d more)","color":"%s"}'):format(
                  ("  "):rep(indent), #keys - i, rtt.line_limit
                )
              else
                strs[#strs+1] = (',{"text":"\n%s  · · ·  (%d more)","color":"%s","hoverEvent":%s}'):format(
                  ("  "):rep(indent), #keys - i, rtt.line_limit, JSON.hoverData.tableMore(x, keys, i)
                )
              end
              break
            end
          end
          str = str .. ('%s,{"text":"\n%s}","color":"%s"}'):format(
            table.concat(strs), ("  "):rep(math.max(indent-1, 0)), rtt.bracket
          )
        end
        return str
      end,
      ---@param x function
      ---@param detail? boolean
      ---@param inHover? boolean
      ---@return string
      ["function"] = function(x, detail, inHover)
        local s, dump = pcall(string.dump, x)
        local insert
        if not inHover then
          if not O[x] then O[x] = true end
          insert = "O[" .. O[x] .. "]"
        end
        local str
        if s then
          local fname, flines = tostring(x):match("^function: ([^:]+)(:%d+%-%d+)$")
          str = (',[{"text":"function:","color":"%s"%s},{"text":" %s","color":"%s"},{"text":"%s","color":"%s"}'):format(
            rtf.default,
            not inHover and (',"insertion":"%s","hoverEvent":%s'):format(
              insert, JSON.hoverData["function"](x, #dump)
            ) or "",
            fname:gsub("([\\\"])", "\\%1"), rtf.script,
            flines, rtf.lines
          )
        else
          local fid = tostring(x):match(" ?([%w_]+)$")
          local ftype = fid and (
            (tonumber(fid) or figuraFIDs[fid]) and "figura" or "builtin"
          ) or "unknown"
          str = (',[{"text":""%s},[{"text":"function: ","color":"%s"},{"text":"%s:","color":"%s"},"%s"]'):format(
            not inHover and (',"insertion":"%s","hoverEvent":%s'):format(
              insert, JSON.hoverData["function"](x)
            ) or "",
            rtf.default,
            ftype, rtf[ftype],
            (fid or "<NAME ERROR>"):gsub("([\\\"])", "\\%1")
          )
        end
        if detail then
          if s then
            str = str .. (',{"text":" (%d byte%s)","color":"%s"}'):format(
              #dump, #dump ~= 1 and "s" or "", rtf.bytes
            )
          else
            str = str .. (',{"text":" (JAVA)","color":"%s"}'):format(rtf.java)
          end
        end
        return str .. "]"
      end,
      ---@param x userdata
      ---@param inHover? boolean
      ---@return string
      userdata = function(x, _, inHover)
        local ustr = tostring(x):gsub("([\\\"])", "\\%1")
        local insert
        if not inHover then
          if not O[x] then O[x] = true end
          insert = "O[" .. O[x] .. "]"
        end
        if ustr:match("^userdata: ") then
          ustr = ustr:sub(11)
        end
        return (',[{"text":"userdata: ","color":"%s"%s},{"text":"%s","color":"%s"}]'):format(
          rtu.default,
          not inHover and (',"insertion":"%s","hoverEvent":%s'):format(
            insert, JSON.hoverData.userdata(x)
          ) or "",
          ustr, rtu.value
        )
      end,
      ---@param x thread
      ---@param detail? boolean
      ---@param inHover? boolean
      ---@return string
      thread = function(x, detail, inHover)
        local insert
        local status
        if detail or not inHover then status = coroutine.status(x) end
        if not inHover then
          if not O[x] then O[x] = true end
          insert = "O[" .. O[x] .. "]"
        end
        local str = (',[{"text":"%s","color":"%s"%s}'):format(
          tostring(x), rtc.default,
          not inHover and (',"insertion":"%s","hoverEvent":%s'):format(
            insert, JSON.hoverData.thread(x, status)
          ) or ""
        )
        if detail then
          str = str .. (',[{"text":" (","color":"%s"},{"text":"%s","color":"%s"},")"]'):format(
            rtc.parentheses,
            status:gsub("^.", string.upper), rtc[status]
          )
        end
        return str .. "]"
      end,
      ---@param x Vector
      ---@param detail? boolean
      ---@param inHover? boolean
      ---@param max? boolean
      ---@return string
      vector = function(x, detail, inHover, max)
        max = max == nil or max
        local insert
        if not inHover then
          if not O[x] then O[x] = true end
          insert = "O[" .. O[x] .. "]"
        end
        local i = 1
        for j=6,1,-1 do
          if x[j] ~= 0 then i = j break end
        end

        local strs = {}
        if max then
          for j = 1, i do
            strs[#strs+1] = (',"%f"'):format(x[j])
          end
        else
          for j = 1, i do
            local fstr = tostring(x[j])
            local fsub = fstr:sub(1, (fstr:find("%..*$") or #fstr) + 5)
            strs[#strs+1] = (',"%s%s"'):format(
              fsub, (#fstr > #fsub) and "..." or ""
            )
          end
        end
        strs[1] = (',[{"text":""%s},[{"text":"<","color":"%s"},[{"text":%s,"color":"%s"}'):format(
          not inHover and (',"insertion":"%s","hoverEvent":%s'):format(
            insert, JSON.hoverData.vector(x)
          ) or "",
          rtv.bracket,
          strs[1]:sub(2), rtv.default
        )
        strs[#strs] = strs[#strs] .. '],">"]'

        local sep = (',{"text":",","color":"%s"}'):format(rtv.seperator)
        local str = table.concat(strs, sep)

        if detail then
          str = str .. (',{"text":" (%d/6 indexes)","color":"%s"}'):format(
            i, rtv.indexes
          )
        end
        return str .. "]"
      end,
      ---@param x any
      ---@param detail? boolean
      ---@param inHover? boolean
      ---@return string
      other = function(x, detail, inHover)
        local str = (',[{"text":"%s","color":"%s"%s}'):format(
          tostring(x):gsub("([\\\"])", "\\%1"), rto.default,
          not inHover and (',"hoverEvent":' .. JSON.hoverData.other(x)) or ""
        )
        if detail then
          str = str .. (',{"text":" (%s)","color":"%s"}'):format(
            type(x), rto.type
          )
        end
        return str .. "]"
      end
    }
    local o2b = {
      ["0"] = "000", ["1"] = "001", ["2"] = "010", ["3"] = "011",
      ["4"] = "100", ["5"] = "101", ["6"] = "110", ["7"] = "111"
    }
    local vectorObj = {
      asTable = 1, toDeg = 2, toRad = 3, angleTo = 4, cross = 5, dot = 6, normalized = 7,
      getLength = 8, distanceTo = 9
    }
    function JSON.stringify.vectorMethods()
      local str = (',{"text":"table: LuaVector","color":"%s"},{"text":" {","color":"%s"},{"text":" (9 indexes)","color":"%s"}'):format(
        rtt.default,
        rtt.bracket,
        rtt.indexes
      )
      local keys = {}
      for k in pairs(vectorObj) do keys[#keys+1] = k end
      table.sort(keys)
      local strs = {}
      for _, k in ipairs(keys) do
        local v = vectorObj[k]
        strs[#strs+1] = (',[{"text":"\n  [","color":"%s"}%s,"]"],{"text":" = ","color":"%s"},[{"text":"function: ","color":"%s"},{"text":"figura:","color":"%s"},"%s"],{"text":" (JAVA)","color":"%s"}'):format(
          rtt.key_bracket,
          JSON.stringify.any(k, false, false, {length = rtt.skey_len, indent = false, max = false}),
          rtt.equals,
          rtf.default,
          rtf.figura,
          v,
          rtf.java
        )
      end
      return str .. ('%s,{"text":"\n}","color":"%s"}'):format(
        table.concat(strs),
        rtt.bracket
      )
    end
    JSON.hoverData = {
      ["nil"] = function()
        return ('{"action":"show_text","value":[{"text":"Nil\nnil","color":"%s"}]}'):format(rtx.default)
      end,
      boolean = function(x)
        return ('{"action":"show_text","value":[{"text":"Boolean\n","color":"%s"},{"text":"%s","color":"%s"}]}'):format(
          rtb.default,
          tostring(x),
          x and rtb.t or rtb.f
        )
      end,
      number = function(x)
        local str = ('{"text":"Number\n%s","color":"%s"}'):format(
          tostring(x),
          rtn.default
        )
        if math.floor(x) == x and math.abs(x) <= 0x7FFFFFFFFFFFFFFF then
          local sign = x < 0 and "-" or ""
          x = math.abs(x)
          local ostr = ("%o"):format(x)
          str = str .. (',[{"text":"\nHex: ","color":"%s"},{"text":"%s%s%X\n","color":"%s"},"Oct: ",{"text":"%s%s%s\n","color":"%s"},"Bin: ",{"text":"%s%s%s","color":"%s"}]'):format(
            rta.h_property,
            sign, rtn.hex_prefix, x, rtn.hex,
            sign, rtn.oct_prefix, ostr, rtn.oct,
            sign, rtn.bin_prefix, ostr:gsub(".", o2b):gsub("^0+", "", 1), rtn.bin
          )
        end
        return ('{"action":"show_text","value":[%s]}'):format(str)
      end,
      string = function(x)
        local chars = 0
        for i = 1, #x do
          if math.floor(x:byte(i) * 0.015625) ~= 2 then chars = chars + 1 end
        end
        local mt = getmetatable("")
        return ('{"action":"show_text","value":[{"text":"String\n","color":"%s"}%s,[{"text":"\nBytes: ","color":"%s"},{"text":"%d\n","color":"%s"},"Characters: ",{"text":"%d\n\n","color":"%s"},"Metatable: "%s]]}'):format(
          rts.default,
          JSON.stringify.string(x, false, true, rts.max_h_size),
          rta.h_property,
          #x, rts.bytes,
          chars, rts.characters,
          JSON.stringify.any(mt, true, true, {
            indent = "single",
            length = type(mt) == "string" and rts.value_size or rta.meta_len
          })
        )
      end,
      table = function(x, contentVisible, size)
        local mt = getmetatable(x)
        local str = ('{"text":"Table\n%s\n","color":"%s"},[{"text":"Indexes: ","color":"%s"},{"text":"%d\n\n","color":"%s"},"Metatable: "%s'):format(
          tostring(x), rtt.default,
          rta.h_property,
          size, rtt.indexes,
          JSON.stringify.any(mt, true, true, {
            indent = "single",
            length = type(mt) == "string" and rts.value_size or rta.meta_len
          })
        )
        if not contentVisible then
          str = str .. (',"\n\nContents: "' .. JSON.stringify.table(x, false, true, "single", rtt.content_len))
        end
        return ('{"action":"show_text","value":[%s]]}'):format(str)
      end,
      tableMore = function(x, keys, i)
        local strs = {
          ('{"text":"    · · ·","color":"%s"}'):format(rtt.line_limit)
        }
        for j = i+1, #keys do
          local k = keys[j]
          local v = x[k]
          strs[#strs+1] = (',[{"text":"\n  [","color":"%s"}%s,"]"],{"text":" = ","color":"%s"}%s'):format(
            rtt.key_bracket,
            JSON.stringify.any(k, false, true, {
              indent = false, length = rtt.skey_len, max = false
            }),
            rtt.equals,
            JSON.stringify.any(v, true, true, {
              indent = false, length = rts.value_size
            })
          )
          if j >= (i+rtt.more_len) and j ~= #keys then
            strs[#strs+1] = (',{"text":"\n    · · ·  (%d more)","color":"%s"}'):format(
              #keys - j, rtt.line_limit
            )
            break
          end
        end
        return ('{"action":"show_text","value":[%s,{"text":"\n}","color":"%s"}]}'):format(
          table.concat(strs), rtt.bracket
        )
      end,
      ["function"] = function(x, size)
        local str = ('{"text":"Function\n","color":"%s"}%s,[{"text":"\nSource: ","color":"%s"},{"text":"%s","color":"%s"}'):format(
          rtf.default,
          JSON.stringify["function"](x, false, true),
          rta.h_property,
          size and "Lua" or "Java", size and rtf.lua or rtf.java
        )
        if size then
          str = str .. (',"\nBytes: ",{"text":"%d","color":"%s"}'):format(
            size, rtf.bytes
          )
        end
        return ('{"action":"show_text","value":[%s]]}'):format(str)
      end,
      userdata = function(x)
        return ('{"action":"show_text","value":[{"text":"Userdata\n","color":"%s"},{"text":"%s","color":"%s"}]}'):format(
          rtu.default,
          tostring(x):gsub("([\\\"])", "\\%1"), rtu.value
        )
      end,
      thread = function(x, status)
        return ('{"action":"show_text","value":[{"text":"Thread\n%s\n","color":"%s"},{"text":"Status: ","color":"%s"},{"text":"%s","color":"%s"}]'):format(
          tostring(x), rtc.default,
          rta.h_property,
          status, rtc[status]
        )
      end,
      vector = function(x)
        local str = ('{"text":"Vector\n","color":"%s"}%s,[{"text":"\nLength: ","color":"%s"},{"text":"%f\n","color":"%s"}'):format(
          rtv.default,
          JSON.stringify.vector(x, false, true, true),
          rta.h_property,
          x.getLength(), rtv.length
        )
        if
          (x[1] >= 0 and x[1] <= 1) and
          (x[2] >= 0 and x[2] <= 1) and
          (x[3] >= 0 and x[3] <= 1)
        then
          local rgb_r,rgb_g,rgb_b = math.floor(x[1]*255), math.floor(x[2]*255), math.floor(x[3]*255)
          local rgb_hsv = vectors.rgbToHSV(x)
          local rgb_h,rgb_s,rgb_v = math.floor(rgb_hsv[1]*360)%360, math.floor(rgb_hsv[2]*10000)*0.01, math.floor(rgb_hsv[3]*10000)*0.01

          local hsv_h, hsv_s, hsv_v = math.floor(x[1]*360)%360, math.floor(x[2]*10000)*0.01, math.floor(x[3]*10000)*0.01
          local hsv_rgb = vectors.hsvToRGB(x)
          local hsv_r, hsv_g, hsv_b = math.floor(hsv_rgb[1]*255), math.floor(hsv_rgb[2]*255), math.floor(hsv_rgb[3]*255)
          str = str .. (',"\n[RGB]:\n  Color: ",{"text":"Lorem_Ipsum █ ⏹⏺◆\n","color":"#%06X"},"    RGB: ",{"text":"⏺ %d","color":"#%02X0000"},", ",{"text":"⏺ %d","color":"#00%02X00"},", ",{"text":"⏺ %d\n","color":"#0000%02X"},"    HSV: ",{"text":"⏺ %d°","color":"#%06X"},", ",{"text":"⏺ %s%%","color":"#%06X"},", ",{"text":"⏺ %s%%\n","color":"#%06X"},"[HSV]:\n  Color: ",{"text":"Lorem_Ipsum █ ⏹⏺◆\n","color":"#%06X"},"    HSV: ",{"text":"⏺ %d°","color":"#%06X"},", ",{"text":"⏺ %s%%","color":"#%06X"},", ",{"text":"⏺ %s%%\n","color":"#%06X"},"    RGB: ",{"text":"⏺ %d","color":"#%02X0000"},", ",{"text":"⏺ %d","color":"#00%02X00"},", ",{"text":"⏺ %d\n","color":"#0000%02X"}'):format(
            vectors.rgbToINT(x),
            rgb_r, rgb_r,
            rgb_g, rgb_g,
            rgb_b, rgb_b,
            rgb_h, vectors.rgbToINT(vectors.hsvToRGB(vectors.of{rgb_hsv[1], 1, 1})),
            tostring(rgb_s), vectors.rgbToINT(vectors.hsvToRGB(vectors.of{0, rgb_hsv[2], 1})),
            tostring(rgb_v), vectors.rgbToINT(vectors.hsvToRGB(vectors.of{0, 0, rgb_hsv[3]})),

            vectors.rgbToINT(vectors.hsvToRGB(x)),
            hsv_h, vectors.rgbToINT(vectors.hsvToRGB(vectors.of{x[1], 1, 1})),
            tostring(hsv_s), vectors.rgbToINT(vectors.hsvToRGB(vectors.of{0, x[2], 1})),
            tostring(hsv_v), vectors.rgbToINT(vectors.hsvToRGB(vectors.of{0, 0, x[3]})),
            hsv_r, hsv_r,
            hsv_g, hsv_g,
            hsv_b, hsv_b
          )
        end

        return ('{"action":"show_text","value":[%s,"\nMethods: "%s]]}'):format(
          str,
          JSON.stringify.vectorMethods()
        )
      end,
      other = function(x)
        return ('{"action":"show_text","value":[{"text":"%s\n","color":"%s"},{"text":"%s","color":"%s"}]}'):format(
          ---That's a load of bull, LLS.
          ---@diagnostic disable-next-line: undefined-field
          type(x):gsub("^.", string.upper), rto.type,
          tostring(x):gsub("\\\"", "\\%1"), rto.default
        )
      end
    }
  end

  REPL = {
    currentcommand = "",
    stringify = JSON.stringify,
    theme = repl_theme,
    bound = false,
    key = keybind.newKey("[REPL] Bind to Chat", "GRAVE_ACCENT"),
    keyWP = false,
    log = function(x, detail, inHover, options)
      options = type(options) == "table" and options or {}
      log(('[{"text":"","italic":false}%s]'):format(
        JSON.stringify.any(x, detail, inHover, {
          indent = options.indent, length = options.length, max = options.max
        })
      ), true)
    end,
    --Not yet...
    RegisterStringifier = function(name, stringify)

    end
  }
  local REPL = REPL
  local REPLSuperActions = {
    fixstringmt = {
      func = function()
        local t = {}
        for k,f in pairs(string) do
          t[k] = f
        end
        getmetatable("").__index = t
        log("Set string metatable index to " .. tostring(t))
      end,
      desc = "Repairs the string metatable.",
      help = "Repairs the string metatable.\n" ..
      "This is useful if you somehow broke string methods.\n" ..
      "The string metatable is required to be functional for the REPL to run.\n" ..
      "Usage:\n" ..
      "  $$#fixstringmt"
    },
    error = {
      func = function()
        error("forced critical REPL error.")
      end,
      desc = "Force a critical error in the REPL.",
      help = "Force a critical error in the REPL.\n" ..
      "Used to emulate a Lua error in the REPL itself instead of an error with REPL input.\n" ..
      "Usage:\n" ..
      "  $$#error"
    },
    avatarerror = {
      func = function(yes)
        if yes == "yes" then
          return "\0\9\0\70\79\82\67\69\0\9\0"
        else
          log("Please use \"$$#avatarerror yes\" to confirm.")
        end
      end,
      desc = "Force your avatar to error.",
      help = "Force your avatar to error.\n" ..
      "The only way to reverse this action is to reload the avatar.\n" ..
      "Usage:\n" ..
      "  $$#avatarerror - Does nothing.\n" ..
      "  $$#avatarerror yes - Causes an avatar error."
    },
    mlcancel = {
      func = function()
        if REPL.currentcommand == "" then
          log("There is no current Multi-line input!")
        else
          REPL.currentcommand = ""
        end
      end,
      desc = "Cancels the current multi-line input.",
      help = "Cancels the current multi-line input.\n" ..
      "Useful if you want to cancel an entire chunk of multi-line Lua without causing issues.\n" ..
      "Usage:\n" ..
      "  $$#mlcancel"
    },
    mlback = {
      func = function()
        local lastline = REPL.currentcommand:find("[^\n]*\n$")
        if lastline then
          REPL.currentcommand = REPL.currentcommand:sub(1, lastline-1)
        else
          log("There is no current Multi-line input!")
        end
      end,
      desc = "Deletes the last line of a multi-line input.",
      help = "Deletes the last line of a multi-line input.\n" ..
      "Useful if you make an error and you want to try again.\n" ..
      "Usage:\n" ..
      "  $$#mlback"
    },
    mlrun = {
      func = function()
        if REPL.currentcommand == "" then
          log("There is no current Multi-line input!")
        else
          REPL()
        end
      end,
      desc = "Run the current Multi-line input as is.",
      help = "Run the current Multi-line input as is.\n" ..
      "Useful if you accidentally start a new line instead of running the input.\n" ..
      "Usage:\n" .. 
      "  $$#mlrun"
    },
    mlprint = {
      func = function()
        if REPL.currentcommand == "" then
          log("There is no current Multi-line input!")
        else
          log(('[{"text":"Current input:\n","italic":false},{"text":"%s","color":"%s"}]'):format(
            REPL.currentcommand:gsub("([\\\"])", "\\%1"),
            rtr.user_input
          ), true)
        end
      end,
      desc = "Prints the current Multi-line input to chat.",
      help = "Prints the current Multi-line input to chat.\n" ..
      "Useful if you forgot where you were in your multi-line input.\n" ..
      "Usage:\n" .. 
      "  $$#mlprint"
    },
    sync = {
      func = function(ccmd)
        if #ccmd > 0 then
          ping.REPLSync(ccmd)
        end
      end
    },
    set = {
      func = function(args)
        local cat, set, val = args:match("^([^.]*)%.?(%S*) ?(.*)$")
        if cat == "" then
          local options = {}
          for k in pairs(repl_theme) do
            if k ~= "" then options[#options+1] = k end
          end
          table.sort(options)
          local strs = {}
          for _,k in ipairs(options) do
            strs[#strs+1] = k
          end
          log("Categories:\n" .. table.concat(strs, ", "))
        elseif not repl_theme[cat] then
          log(("Theme category [%s] not found.\nUse \"$$#set\" to list all categories."):format(cat))
        elseif set == "" then
          local tcat = repl_theme[cat]
          local options = {}
          for k in pairs(tcat) do
            if k ~= "" then options[#options+1] = k end
          end
          table.sort(options)
          local strs = {}
          for _,k in ipairs(options) do
            local v = tcat[k]
            strs[#strs+1] = ("[%s] - %s"):format(
              k,
              (type(v) == "string" and not v:match("^#%x%x%x%x%x%x$"))
                and ('"' .. tostring(v):gsub("([\\\"])", "\\%1") .. '"')
                 or tostring(v)
            )
          end
          log("Settings for category:\n[" .. cat .. "]:\n  " .. table.concat(strs, "\n  "))
        elseif repl_theme[cat][set] == nil then
          log(("Theme setting [%s.%s] not found.\nUse \"$$#set %s\" to list all settings in this category."):format(
            cat, set,
            cat
          ))
        elseif val == "" then
          local tset = repl_theme[cat][set]
          local tsett = type(tset)
          log(("Value for setting:\n[%s.%s]:\n  %s"):format(
            cat, set,
            (tsett == "string" and not tset:match("^#%x%x%x%x%x%x$"))
              and ('"' .. tostring(tset):gsub("([\\\"])", "\\%1") .. '"')
               or (tsett == "number" and math.abs(tset) == math.huge)
                    and (tset < 0 and "-Infinity" or "Infinity")
                     or tostring(tset)
          ))
        else
          ---@type string|number|boolean
          local value
          if val:match("^\".+\"$") then
            value = val:sub(2,-2)
          elseif val:match("^#%x%x%x%x%x%x$") then
            value = val
          elseif tonumber(val) then
            value = tonumber(val)
          elseif val == "true" or val == "false" then
            value = val == "true"
          elseif val:match("^%-?[Ii]nfinity$") or val:match("^%-?[Ii]nf$") then
            local m = val:sub(1,1) == "-"
            value = m and -math.huge or math.huge
          else
            log("Invalid value. Please do \"$$#help set\" to see what values can be used.")
            return
          end
          repl_theme[cat][set] = value
        end
      end,
      desc = "Quickly set REPL theme settings.",
      help = "Quickly set REPL theme settings.\n" ..
      "Please make sure you are using sane values. The resulting value is not checked.\n" ..
      "Usage:\n" ..
      "  $$#set - View all categories.\n" ..
      "  $$#set <category> - View all settings in the category.\n" ..
      "  $$#set <category.setting> - View the current value for this setting.\n" ..
      "  $$#set <category.setting> <value> - Sets the setting to the given value.\n" ..
      "    <value> can be:\n" ..
      "      {string} (\"string\"),\n" ..
      "      {number} (123.45),\n" ..
      "      {boolean} (true/false)"
    }
  }

  local RSABlCSt, RSABlCStT, RSABlCStH = false, "", "" if loadSecrets then
    --[[
      I see you are poking around...

      Everything in this block is part of the "REPL Secret" and is for fun.
      If you ruin the fun and cheat to view these then I will be disappointed in you :(

      If you *really* want a hint to one of them, mention GrandpaScout with the message
      "I need a REPL moment." in the general chat of whatever Discord server is hosting Figura.
      You will get a reply as soon as the message is recieved. The reply will have a warning and
      will be spoilered to avoid spoiling it for others.
    ]]--

    local function RSASt2Sc(a)
      ---@diagnostic disable-next-line: deprecated
      return loadstring("return ".. loadstring(([[return(%s):gsub("(%%d%%d%%d)",function(a)return _G["\115\116\114\105\110\103"]["\99\104\97\114"](_G["\116\111\110\117\109\98\101\114"](a))end)]]):format(a))())()
    end
    RSABlCSt = RSASt2Sc[[(0 ..0x1EF6BAD164A9 ..0x9EB5E76D48F ..0x3BE5BEF1E60 ..0x931D9C4F0FF ..0x24F8D26F541A ..0x3DF25A8612EC ..0x98F37246B83 ..0x6C7D92)]]
    RSABlCStT = RSASt2Sc[[(0 ..0x1EFD07B8A344 ..0x93226C12A77 ..0x40AF269AE82A ..0x5A25443C9646 ..0xA76E7ABBE7B ..0x4)]]
    RSABlCStH = RSASt2Sc[[(0 ..0x319C4710DF4 ..0x4998C482275A ..0x630D54ECBA1 ..0x12A095FD6C98 ..0xBBA2)]]

    local a = RSASt2Sc[[(
        0x0B3231CBD021 ..0x526905BAC99C ..0x00E6C5CD67E7 ..0x0921A115728F ..0x095F167E326F
      ..0x256F8B738488 ..0x1EF9C105B2BE ..0x0AA6D8708B36 ..0x37FFC3C02FD8 ..0x1F0351679E0F
      ..0x0A5F0FF3BF8B ..0x2E1CAD3F0564 ..0x3C13A2D6FE82 ..0x098F6CC348DA ..0x2E601D23269C
      ..0x08D4F9787560 ..0x2DD4705871B5 ..0x0F8DA57AE936 ..0x091955403431 ..0x12A095FD6C98
      ..0x045F43E24636 ..0x496349555AA0 ..0x085F29620443 ..0x2539E689E835 ..0x00000104F145
    )]]
    REPLSuperActions[RSASt2Sc[[(0 ..0x1F0315CCDFC6 ..0x643B6EA)]]] = a
    REPLSuperActions[RSASt2Sc[[(0 ..0x1F0315BDB4FD ..0x1D8CA)]]] = a
    REPLSuperActions[RSASt2Sc[[(0 ..0x1F047A97F46A ..0xAA6C6738BDF ..0xFC2)]]] = a

    REPLSuperActions[RSASt2Sc[[(0 ..0x1F047AD4F98C ..0x1B5A2)]]] = RSASt2Sc[[(
        0x0B3231CBD021 ..0x526905BAC99C ..0x00E6C5CD67E7 ..0x0921A115728F ..0x095F167E326F
      ..0x256F8B738488 ..0x0318F9B3C707 ..0x096309D1B6DE ..0x1D2BD5A43A75 ..0x0B01FF8B9727
      ..0x03AACC21F4F4 ..0x09D52E028E0C ..0x24B09E71EFA9 ..0x0102C4CE21EB ..0x24B2D7A235E2
      ..0x04A4A5F8F2EC ..0x03AB436705C1 ..0x09D5049A462D ..0x075E6A9EBC93 ..0x09328033F89B
      ..0x058F8DC725F1 ..0x09322728DDB9 ..0x0967AEE45498 ..0x045FBAF1B627 ..0x1BE76712F45C
      ..0x085F29620449 ..0x12A073723033 ..0x0EA7DC39C645
    )]]

    REPLSuperActions[RSASt2Sc[[(0 ..0x1F0351C34AC9 ..0x18AAA)]]] = RSASt2Sc[[(
        0x0B3231CBD021 ..0x526905BAC99C ..0x00E6C5CD67E7 ..0x0921A115728F ..0x095F167E326F
      ..0x256F8B738488 ..0x0318F9B3C76A ..0x2DE00D6584B4 ..0x08D4DB95B5F6 ..0x401553900D14
      ..0x09039C3D3DE7 ..0x24B085F6127E ..0x045EBABED2C9 ..0x0669EDFBF082 ..0x098F6CC348DA
      ..0x2E601D23269C ..0x08D4F9787560 ..0x2DD4705871B5 ..0x0F8DA57AE936 ..0x091955403431
      ..0x12A095FD6C98 ..0x045F43E24636 ..0x496349555AA0 ..0x085F29620443 ..0x2539E689E835
      ..0x00000104F145
    )]]

    a = RSASt2Sc[[(
        0x0B3231CBD021 ..0x526905BAC99C ..0x00E6C5CD67E7 ..0x0921A115728F ..0x095F167E326F
      ..0x256F8B738488 ..0x1EF9C1060C97 ..0x0AA4DDBC283F ..0x49ADE03DDEFC ..0x58510B785A74
      ..0x0A192ADEE53F ..0x06789D11CEAD ..0x09309D5D23C3 ..0x492DA202AD14 ..0x09039C3D3DE7
      ..0x24B085F6127E ..0x04BC4DDD3629 ..0x03AFE7425482 ..0x098F6CC348DA ..0x2E601D23269C
      ..0x08D4F9787560 ..0x2DD4705871B5 ..0x0F8DA57AE936 ..0x091955403431 ..0x12A095FD6C98
      ..0x045F43E24636 ..0x496349555AA0 ..0x085F29620443 ..0x2539E689E835 ..0x00000104F145
    )]]
    REPLSuperActions[RSASt2Sc[[(0 ..0x1F065843EBC8 ..0xA77F9EE04FB ..0x16BA79CB2)]]] = a
    REPLSuperActions[RSASt2Sc[[(0 ..0x1F065843EBC8 ..0xA77F9EE04FB ..0x58C86BD53DA)]]] = a

    a = RSASt2Sc[[(
       (0x0B3231CBD021 ..0x526905BAC99C ..0x00E6C5CD67E7 ..0x0921A115728F ..0x095F167E326F
      ..0x256F8B738488 ..0x004F4C2B94B9 ..0x0927B29E72B8 ..0x0A8F4258B5A2 ..0x40B5F99E5396
      ..0x1D359CF9FCA8 ..0x093227415F8F ..0x03BAD88F4BD9 ..0x0960E1E54627 ..0x1312B7069280
      ..0x3C1FFDA52053 ..0x0AD545908417 ..0x0493A07AE0C5 ..0x09EC94A89ECF ..0x37ABA370E8B7
      ..0x0CC31A671095 ..0x0A6116DBD22A ..0x2E79E2C4ADF9 ..0x09294F8018A1 ..0x0ABDC101B39E
      ..0x0103D8B25B08 ..0x09D528777C0B ..0x0100963B66CA ..0x0931D9C4D60B ..0x01E933FB41AC
      ..0x09309D5D2DE7 ..0x132C54246601 ..0x0A18E4AE4540 ..0x098F0779E887 ..0x02C1F75E606D
      ..0x001927372A29 ..0x091AA8A55EE7 ..0x01EAD46133EC ..0x098F49090CEA ..0x2E77941DDCEF
      ..0x0E94C449A790 ..0x00FE054A7CF9 ..0x092DC0A2F420 ..0x0A1B259F98E7 ..0x40B87F163209
      ..0x0101775D7E7B ..0x01D9210E2115 ..0x09ECAC09112A ..0x01020063F0A0 ..0x094975AAFEC9
      ..0x40A5E123574B ..0x0DABEFF0F2C9 ..0x098F49090CEB ..0x378437C7CA84 ..0x1D32D14DE7F4
      ..0x0932450EA80B ..0x058ED5E5D4A5 ..0x09D5168FBE8B ..0x0A26A1E281C5 ..0x015E45C6D07B
      ..0x01D920B2B6B1 ..0x0960827C8BAF ..0x131E5BDCBFE0 ..0x09039C404CB7 ..0x3773F0D38679
      ..0x1320EADB2301 ..0x0A0389363985 ..0x4090E5927D03 ..0x00034460CF56 ..0x09190DE47A4D
      ..0x52D421A51444 ..0x1D359CFA0C96 ..0x0960D57C6D86 ..0x04A72F903F46 ..0x098F1F6562B1
      ..0x4010CE147020 ..0x1D2AE766AA55 ..0x093244C6FE4F ..0x131E5BDCBFE1 ..0x0EA3E659D556
      ..0x095EE744A18E ..0x52C5FDDC5883 ..0x0E94C4498850 ..0x0A8F425ECE2F ..0x24ABF6F09BCA
      ..0x1D359D63BF30 ..0x001A918D7B19 ..0x091AA8A560E3 ..0x0103617D1188 ..0x093056460A3F
      ..0x01EC3AD79B15 ..0x09190DE47D6E ..0x409EB84AD00C ..0x1D220C37D0B1 ..0x09EC4D20890F
      ..0x377D43F1357D ..0x0A1BAFEF6754 ..0x0AD4F228E78F ..0x01E8809231D6 ..0x095EE727872B)..
       (0x2E6E418DA17A ..0x02EB51AF40D3 ..0x1317634C9DBB ..0x0A1C67B14229 ..0x0A0377C3F9C2
      ..0x2E62A2ADC9C8 ..0x1D3130D88840 ..0x094975AAFECB ..0x0677EA332C5C ..0x098F49090CEB
      ..0x378437BCA5DC ..0x078E0E18161B ..0x09FF139C4BCE ..0x03BBA1DA607B ..0x127B495C1D83
      ..0x0CD57F94E666 ..0x0A1B133DC452 ..0x0A0D08F387B0 ..0x08D3346EFC8E ..0x075C131CAD33
      ..0x00F2637C0F00 ..0x008BD13625D9 ..0x091FC3B55529 ..0x0A03DD11CC59 ..0x2DC446968B64
      ..0x1D33FB53BEA1 ..0x0A038936385A ..0x03BAD88F4BD9 ..0x0960E1E54627 ..0x131C0D2E7733
      ..0x00178D128D67 ..0x000255F5A756 ..0x09190D939F79 ..0x40AA7D457155 ..0x0019E1ADB859
      ..0x091FC3B568B1 ..0x09EC2365DCFF ..0x2DC446968B64 ..0x1D3130BA4E39 ..0x0B03EDD8BB91
      ..0x40A828AC8FDB ..0x001785E05BD7 ..0x000255F5A756 ..0x09190DD84A5C ..0x2537AFA5FE41
      ..0x0EA58738B0B0 ..0x09322D31273A ..0x096316ECF856 ..0x1D356225BB30 ..0x0A1B13BDD70B
      ..0x52CD20BEFB00 ..0x06A4693D09E0 ..0x2537AFA5FE41 ..0x0EA58738B0B0 ..0x09322D31273A
      ..0x096316ECF856 ..0x1D3561D944F6 ..0x09190DDFE92A ..0x01014DEDE7F4 ..0x098F43101EAA
      ..0x03BADD178B50 ..0x098F49090CEB ..0x0A26A1E281C5 ..0x015E45C6D07B ..0x127B6395D472
      ..0x1D34AE613548 ..0x09D4EC5CA786 ..0x2563BE16E3B5 ..0x1320EBCF46B8 ..0x09EC1D6E7557
      ..0x133353413073 ..0x0CD669798C41 ..0x0AA684E45139 ..0x01EB47B5B174 ..0x0977CA8104CA
      ..0x0A1B026CD2B2 ..0x02EBC2E5CAEF ..0x057C75B85093 ..0x09305656D12A ..0x0962F7566B8B
      ..0x092F62683BCA ..0x09BDF7580BF6 ..0x0A220222F4C4 ..0x1D312C325135 ..0x0A8F89E55DAB
      ..0x01EBC373EE4B ..0x09309DB8C07B ..0x127B6395D472 ..0x1D3130401531 ..0x010061AC794B
      ..0x092F98D37A37 ..0x091AA9227E2F ..0x37948BDC2E71 ..0x0A18E4AE3988 ..0x0930560A8779
      ..0x40AA7D52B847 ..0x0CD491948E33 ..0x09323F1BEF3F ..0x24C7E2BC9020 ..0x1D3130D88840)..
       (0x0A1ACBB738B7 ..0x0A28FBE66922 ..0x1D2F8ED6CC54 ..0x0109A7234680 ..0x06607895CF9C
      ..0x24ABD7F58B7C ..0x2D85A64E0844 ..0x093256E7447E ..0x075FCD15984F ..0x09EC70D924FB
      ..0x0A1D2DE523CB ..0x092F98D34B56 ..0x0B01FF8B997F ..0x37A284216390 ..0x3C1FFDA52053
      ..0x0AD545908417 ..0x0493A089FBFE ..0x09321B4DFF2A ..0x0A22004EA97D ..0x0A1BAFEFBD47
      ..0x0A60C358BDA2 ..0x1B93AF0E6BA1 ..0x0EA58738B086 ..0x098F1F6562B1 ..0x3FF4E7A7E858
      ..0x006B5109DA79 ..0x00EA58BB390F ..0x52BCE2B9B468 ..0x004AC87A57F3 ..0x091FC898EB7F
      ..0x0A60B77DC0FA ..0x1B982F2B39FF ..0x0102A1806FEB ..0x24E858C57E42 ..0x05EAF5D4245E
      ..0x36E11A831A3B ..0x0176CA3DB58D ..0x083767D2F551 ..0x09D5403840F7 ..0x0839BF540AC5
      ..0x00178684D936 ..0x091955403431 ..0x12A095FD6C98 ..0x045F43E24636 ..0x496349555AA0
      ..0x085F29620443 ..0x2539E689E835 ..0x00000104F145)
    )]]
    REPLSuperActions[RSASt2Sc[[(0 ..0x1F0403DC5B0D ..0x6CCFB8A)]]] = a
    REPLSuperActions[RSASt2Sc[[(0 ..0x31A0062D5E7 ..0x6C4ACA)]]] = a
    REPLSuperActions[RSASt2Sc[[(0 ..0x4F640E638B ..0x92F62683BCA ..0x662721A)]]] = a
  end
  REPLSuperActions.help = {
    func = function(arg)
      local SA = REPLSuperActions[arg]
      if SA and not SA[RSABlCStH] then
        log(string.format('{"text":"Help for [%s]:\n%s\n","italic":false}',
          arg == "" and "help" or arg,
          SA.help
            and string.gsub(SA.help, "([\\\"])", "\\%1")
             or string.format("No help found for this SuperAction.\nAssumed usage:\n  $$#%s - Run SuperAction", arg)
        ), true)
      else
        log("No SuperAction with that name found.")
      end
    end,
    desc = "Provides help about SuperActions.",
    help = "Provides help about SuperActions.\n" ..
    "Usage:\n" ..
    "  $$#help - Get help about the help SuperAction.\n" ..
    "  $$#help <name> - Get help about the named SuperAction."
  }
  REPLSuperActions[""] = {
    func = function(arg)
      local a = arg == RSABlCSt
      local topics = {}
      for k in pairs(REPLSuperActions) do
        topics[#topics+1] = k
      end
      table.sort(topics)
      local strs = {}
      for _,k in ipairs(topics) do
        v = REPLSuperActions[k]
        if not v[RSABlCStH] then
          strs[#strs+1] = string.format("[$$#%s]: %s", k, v.desc or "No description provided...")
        end
      end
      log("All SuperActions:\n" .. table.concat(strs, "\n") .. "\n")
      if a then
        local astrs = {}
        for _,k in ipairs(topics) do
          if REPLSuperActions[k][RSABlCStH] then
            astrs[#astrs+1] = string.format("@ [$$#%s]", k)
          end
        end
        log(RSABlCStT .. table.concat(astrs, "\n") .. "\n")
      end
    end,
    desc = "List all SuperActions.",
    --"What? That's not what this SA does!"
    --If this were to be typed out in chat, it would look like "$$#help".
    --Therefore, this is actually the help topic for the help SA.
    help = "Provides help about SuperActions.\n" ..
    "Usage:\n" ..
    "  $$#help - Get help about the help SuperAction.\n" ..
    "  $$#help <name> - Get help about the named SuperAction.\n\n" ..
    "If you were looking for a list of SuperActions, try \"$$#\"."
  }
  local REPLmt = {
    __call = function(self, cmd)
      local str, nl
      if cmd ~= nil then
        cmd = tostring(cmd)
        if string.sub(cmd, 1, 3) == "$$#" then
          --Assume the worst, the code in this block should *all* run even if the string metatable is fucked.
          local SAcmd, SAarg = string.match(cmd, "^$$#(%S*) ?(.*)$")
          SAcmd = string.lower(SAcmd)
          if REPLSuperActions[SAcmd] then
            log(string.format('{"text":"REPL: Running SuperAction.","color":"%s","italic":false}', rtr.notice), true)
            local ret = REPLSuperActions[SAcmd].func(SAarg)
            if ret == "\0\9\0\70\79\82\67\69\0\9\0" then
              return "\0\9\0\70\79\82\67\69\0\9\0"
            end
          else
            log(string.format('{"text":"REPL: SuperAction not found!\nUse $$# to list all valid SuperActions.","color":"%s","italic":false}', rtr.error), true)
          end
          return
        end
        str, nl = cmd:match("^(.-)(;?)$")
        if not str then error "Command error." end
        if #REPL.currentcommand == 0 and str:sub(1,1) == "/" then
          log(('{"text":"REPL: Ignoring Minecraft command.","color":"%s","italic":false}'):format(rtr.notice), true)
          ---@diagnostic disable-next-line: missing-parameter
          chat.setFiguraCommandPrefix()
          chat.sendMessage(str)
          chat.setFiguraCommandPrefix("")
          return
        end
        REPL.currentcommand = REPL.currentcommand .. str .. "\n"
      else
        str = ""
      end
      if nl ~= ";" then
        ---@diagnostic disable-next-line: missing-parameter
        chat.setFiguraCommandPrefix()
        local ccmd = REPL.currentcommand:sub(1, -2)
        REPL.currentcommand = ""
        ---@diagnostic disable-next-line: deprecated
        local f = loadstring("return " .. ccmd)
        if type(f) == "function" then
          log(('[{"text":"INPUT:\n","color":"%s","italic":false},{"text":"return ","color":"%s"},{"text":"%s\n","color":"%s"}]'):format(
            rtr.input,
            rtr.repl_return,
            ccmd:gsub("([\\\"])", "\\%1"), rtr.user_input
          ), true)
        else
          ---@diagnostic disable-next-line: deprecated
          f = loadstring(ccmd)
          if type(f) == "function" then
            log(('[{"text":"INPUT:\n","color":"%s","italic":false},{"text":"%s\n","color":"%s"}]'):format(
              rtr.input,
              ccmd:gsub("([\\\"])", "\\%1"), rtr.user_input
            ), true)
          else
            log(('{"text":"REPL: Compile Error!\n%s","color":"%s","italic":false}'):format(
              f:gsub("\t", "  "):gsub("([\\\"])", "\\%1"), rtr.error
            ), true)
            chat.setFiguraCommandPrefix("")
            return
          end
        end
        local r = {pcall(f)}
        if not r[1] then
          log(('{"text":"REPL: Runtime Error!\n%s","color":"%s","italic":false}'):format(
            r[2]:gsub("\t", "  "):gsub("([\\\"])", "\\%1"):gsub("§.", ""), rtr.error
          ), true)
          chat.setFiguraCommandPrefix("")
          return
        end
        table.remove(r, 1)
        local _H = {}
        H[#H+1] = _H
        local rh = 0
        for i in pairs(r) do if i > rh then rh = i end end
        for i=1,rh do
          local v = r[i]
          _H[i] = v
          r[i] = JSON.stringify.any(v, true, false, {
            indent = rtt.max_indent < 0 and rtt.max_indent or nil,
            length = type(v) == "string" and rts.max_size or rtt.max_length
          })
        end
        if rh == 0 then
          r[1] = ('%s,{"text":" (no value?)","color":"%s"}'):format(
            JSON.stringify["nil"](),
            rtx.no_value
          )
        end
        log(('[{"text":"RETURNS:\n","color":"%s","italic":false}%s,"\n"]'):format(
          rtr.returns,
          table.concat(r, ',"\n"')
        ), true)
        chat.setFiguraCommandPrefix("")
      end
    end
  }

  --Store pointer to the Environment.
  --[[ O[1]  ]] O[_ENV] = true

  --Store pointers to REPL values.
  --[[ O[2]  ]] O[REPL] = true
  --[[ O[3]  ]] O[REPL.key] = true
  --[[ O[4]  ]] O[REPL.log] = true
  --[[ O[5]  ]] O[REPL.stringify] = true
  --[[ O[6]  ]] O[REPL.theme] = true

  --Store pointer to REPL metatable.
  --[[ O[7]  ]] O[REPLmt] = true

  --Store pointers to O values.
  --[[ O[8]  ]] O[O] = true
  --[[ O[9]  ]] O[O.N] = true
  --[[ O[10] ]] O[O.Nindex] = true

  --Store pointers to instances.
  REPLINSTANCE_Biome = biome.getBiome("minecraft:plains", {})
  --[[ O[11] ]] O[REPLINSTANCE_Biome] = true

  REPLINSTANCE_BlockState = block_state.createBlock("minecraft:chest")
  --[[ O[12] ]] O[REPLINSTANCE_BlockState] = true

  REPLINSTANCE_ItemStack = item_stack.createItem("minecraft:shield")
  --[[ O[13] ]] O[REPLINSTANCE_ItemStack] = true

  REPLINSTANCE_FiguraKeybind = keybind.newKey("[REPL] <INTERNAL USE>", "UNKNOWN")
  --[[ O[14] ]] O[REPLINSTANCE_FiguraKeybind] = true

  REPLINSTANCE_RegisteredKeybind = keybind.getRegisteredKeybind("key.jump")
  --[[ O[15] ]] O[REPLINSTANCE_RegisteredKeybind] = true

  REPLINSTANCE_Vector = vectors.of{1,2,3,4,5,6}
  --[[ O[16] ]] O[REPLINSTANCE_Vector] = true

  ---@type {[boolean]: number, [number]: string, [string]: table, [table]: Vector, [Vector]: userdata, [userdata]: boolean}
  REPL.testtable = {
    [true] = 123.456,
    [123.456] = "\abcxyz",
    ["qwer\ty"] = {"hello", "world", {"!"}},
    [{"foo","bar","baz",yalike="jazz?"}] = vectors.of{1,2,3,4,5,math.sqrt(2)},
    [vectors.of{1,2,3,4,5,math.sqrt(2)}] = REPLINSTANCE_BlockState["figura$block_state"],
    [REPLINSTANCE_ItemStack["figura$item_stack"]] = false
  }

  setmetatable(REPL, REPLmt)

  onCommand = function(cmd)
    if REPL.bound then
      local s, e = pcall(REPLmt.__call, nil, cmd)
      if not s then
        --Again, we have to assume the worst.
        log(
          string.format(
            '{"text":"REPL: Critical REPL error!\n%s","color":"%s","italic":"false"}',
            string.gsub(string.gsub(string.gsub(e, "\t", "  "), "([\\\"])", "\\%1"), "§.", ""),
            rtr.error
          ),
          true
        )

        if not checkSMT() then
          log('{"text":"\nThe string metatable has been tampered with!\nCore REPL functions cannot run without a valid string metatable!\nYou can use \\"$$#fixstringmt\\" to attempt to fix the issue.","color":"dark_red","italic":false}', true)
        end
        chat.setFiguraCommandPrefix("")
      elseif e == "\0\9\0\70\79\82\67\69\0\9\0" then
        error("FORCED AVATAR ERROR.\nRELOAD AVATAR TO REGAIN CONTROL.\n")
      end
    end
  end

  function tick()
    local REPLkeyIP = REPL.key.isPressed()
    if REPLkeyIP and not REPL.keyWP then
      if REPL.bound then
        REPL.bound = false
        ---@diagnostic disable-next-line: missing-parameter
        chat.setFiguraCommandPrefix()
        log(string.format('{"text":"REPL: Unbound from chat.","color":"%s","italic":false}', rtr.notice), true)
      else
        REPL.bound = true
        chat.setFiguraCommandPrefix("")
        log(string.format('{"text":"REPL: Bound to chat.","color":"%s","italic":false}', rtr.notice), true)
      end
    end
    REPL.keyWP = REPLkeyIP
  end
end

function ping.REPLSync(ccmd)
  ---@diagnostic disable-next-line: deprecated
  local f = loadstring("return " .. ccmd)
  if type(f) ~= "function" then
    ---@diagnostic disable-next-line: deprecated
    f = loadstring(ccmd)
    if type(f) ~= "function" then
      log("REPLSync Compile error:\n" .. f)
      return
    end
  end
  local r = {pcall(f)}
  if not r[1] then
    log("REPLSync Runtime Error:\n" .. r[2])
    return
  end
end
