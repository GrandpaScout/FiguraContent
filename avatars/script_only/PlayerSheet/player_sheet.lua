---@type PlayerSheet
local PlayerSheet
do
--[[>========================================<< INFO >>========================================<[]--
    FIGURA PLAYER SHEET GENERATOR
    By: GrandpaScout [STEAM_1:0:55009667]
    Version: 2.0.1
    Compatibility: >= Figura 0.0.8
    Description:
      A tool used to create Player Sheets.
      This tool is meant to be used to build a player sheet which is then imported as text into
      another avatar as this tool can take up to 10,000 instructions to create the sheet while
      importing it as text only takes around around 5 instructions.
--[]>======================================<< END INFO >>======================================<]]--

  local PSLang = {
    title = "Player Sheet",
    unknown = "???",
    none = "None",

    l_player = "Player",
    l_char = "Character",
    l_avatar = "Avatar",

    a_trust = "Recommended Trust Level",
    a_trust0 = "Untrusted",
    a_trust1 = "Trusted",
    a_trust2 = "Friend",
    a_filesize = "File Size",
    a_complex = "Complexity",
    a_init = "Init",
    a_tick = "Max Tick",
    a_render = "Max Render",
    a_particles = "Max Particles",
    a_sounds = "Max Sounds",
    a_vanilla = "Vanilla Changes",
    a_nameplate = "Nameplate Changes",
    a_offscreen = "Offscreen Rendering",
    a_renderlayers = "Custom Render Layers",
    a_customsounds = "Custom Sounds",
    a_tracking = "Player Tracking",

    s_hzbar = ("\\uff0d"):rep(24),
    s_yes = "\\u25c6",
    s_no = "\\u25c7",
    s_unk = "\\ufffd",
    s_mark = "\\u25b3",
    s_almost = "\\u2248",

    --*THIS IS MEANT TO BE A STANDARD SYMBOL, DO NOT CHANGE IT.*
    --
    --This is only here for quick access in code!
    menu = "\\u2630"
  }

  local PSTheme = {
    title = "white",
    unknown = "white",
    label0 = "#7F55FF",
    label1 = "#7F55FF",
    label2 = "#7F55FF",
    uuid = "#7F7F7F",
    key = "gray",
    number = "white",
    trust0 = "gray",
    trust1 = "green",
    trust2 = "#007FFF",

    hzbar = "#2E0A65",
    yes = "green",
    no = "dark_gray",
    unk = "white",

    --*THIS IS MEANT TO BE A STANDARD COLOR, DO NOT CHANGE IT.*
    --
    --This is only here for quick access in code!
    menu = "gray"
  }

  local json = {
    valid_escapes = {
      b = true, f = true, n = true, r = true, t = true, u = true,
      ['"'] = true, ["\\"] = true, ["/"] = true
    },
    null = "null",
    nl = '"\n"'
  }

  ---Verifies and creates a quoted JSON string.
  ---@param s string?
  ---@return string?
  function json.qstring(s)
    if s == nil then return end
    s = tostring(s)
    if s:match("\\$") then
      error('attempt to escape outside the string boundary (string ends in "\\")', 2)
    else
      local jve = json.valid_escapes
      for n, m in s:gmatch("()\\(.)") do
        if not jve[m] then
          error("invalid escape sequence at position " .. n .. ' ("\\' .. m .. '")', 2)
        elseif m == "u" and not s:sub(n+2, n+6):match("%x%x%x%x") then
          error(
            "invalid unicode escape sequence at position " .. n ..
            ' ("\\u' .. s:sub(n+2, n+6) .. '")'
          )
        end
      end
    end
    return '"' .. s:gsub('"', '\\"') .. '"'
  end

  ---@param b boolean?
  ---@return boolean?
  function json.jbool(b)
    if b == nil then return end
    return b and true or false
  end

  ---@param t table?
  ---@return string?
  function json.jobj(t)
    if t == nil then return end
    local strs = {}
    for k,v in pairs(t) do
      strs[#strs+1] = json.qstring(k) .. ':' .. tostring(v)
    end
    return "{" .. table.concat(strs, ",") .. "}"
  end

  ---@class SheetFormat
  ---@field bold boolean?
  ---@field italic boolean?
  ---@field underlined boolean?
  ---@field strikethrough boolean?
  ---@field obfuscated boolean?
  ---@field font string?

  --============================================================================================--

  ---@class SheetText
  ---The text in this Text object.
  ---@field text string
  ---The color of this Text object.
  ---@field color string
  ---The formatting of this Text object. A table of formatting keys and values.
  ---@field format SheetFormat
  ---For internal use.
  ---@field private _json string
  local SheetText = {}
  local ST_mt = {__index = SheetText}

  ---Create a new Text object.
  ---@param text? string
  function SheetText:New(text)
    return setmetatable({
      text = type(text) == "string" and text or "",
      format = {}
    }, ST_mt)
  end

  ---For internal use.
  ---@return SheetText
  function SheetText:Build()
    local format = self.format
    self._json = json.jobj{
      text = json.qstring(self.text),
      color = json.qstring(self.color),
      font = json.qstring(format.font),
      bold = json.jbool(format.bold),
      italic = json.jbool(format.italic),
      underlined = json.jbool(format.underlined),
      strikethrough = json.jbool(format.strikethrough),
      obfuscated = json.jbool(format.obfuscated)
    }
    return self
  end

  ---For internal use.
  ---@return string
  function SheetText:ToJson()
    if not self._json then self:Build() end
    return self._json
  end

  ---Sets the text (and optionally, color and format) of this text.  
  ---Set `color` or `format` to `false` to clear them.
  ---@param text string
  ---@param color? string|"false"
  ---@param format? SheetFormat|"false"
  ---@return SheetText
  function SheetText:SetText(text, color, format)
    self.text = text
    if type(color) == "string" then
      ---@type string
      self.color = color
    elseif color == false then
      self.color = nil
    end
    if type(format) == "table" then
      ---@type SheetFormat
      self.format = format
    elseif format == false then
      self.format = {}
    end
    return self
  end

  ---Sets the color of this text.
  ---@param color string?
  ---@return SheetText
  function SheetText:SetColor(color)
    self.color = type(color) == "string" and color or nil
    return self
  end

  ---Sets if this text is bolded.
  ---@param set boolean?
  ---@return SheetText
  function SheetText:SetBold(set)
    self.format.bold = set
    return self
  end

  ---Sets if this text is italicized.
  ---@param set boolean?
  ---@return SheetText
  function SheetText:SetItalic(set)
    self.format.italic = set
    return self
  end

  ---Sets if this text is underlined.
  ---@param set boolean?
  ---@return SheetText
  function SheetText:SetUnderlined(set)
    self.format.underlined = set
    return self
  end

  ---Sets if this text is striked.
  ---@param set boolean?
  ---@return SheetText
  function SheetText:SetStrikethrough(set)
    self.format.strikethrough = set
    return self
  end

  ---Sets if this text is obfuscated.
  ---@param set boolean?
  ---@return SheetText
  function SheetText:SetObfuscated(set)
    self.format.obfuscated = set
    return self
  end

  ---Sets the font of this text.
  ---@param font string?
  ---@return SheetText
  function SheetText:SetFont(font)
    self.format.font = font
    return self
  end

  --============================================================================================--

  ---@class SheetKeyValue
  ---The key name of this Key/Value pair.
  ---@field key string
  ---The value Text object of this Key/Value pair.
  ---@field value SheetText
  ---For internal use.
  ---@field private _json string
  local SheetKeyValue = {}
  local SKV_mt = {__index = SheetKeyValue}

  ---Create a new Key/Value pair.
  ---@param key string
  function SheetKeyValue:New(key)
    return setmetatable({
      key = tostring(key),
      value = SheetText:New()
    }, SKV_mt)
  end

  ---For internal use.
  ---@return SheetKeyValue
  function SheetKeyValue:Build()
    self._json = json.jobj{
      text = json.qstring(self.key .. ": "),
      color = '"' .. PSTheme.key .. '"',
    } .. "," .. self.value:ToJson()
    return self
  end

  ---For internal use.
  ---@return string
  function SheetKeyValue:ToJson()
    if not self._json then self:Build() end
    return self._json
  end

  ---Sets the key of this Key/Value pair.
  ---@param key string
  ---@return SheetKeyValue
  function SheetKeyValue:SetKey(key)
    self.key = tostring(key)
    return self
  end

  ---Gets the value of this Key/Value pair for using methods on.
  function SheetKeyValue:GetValue()
    return self.value
  end

  --============================================================================================--

  ---@class SheetKeyBoolean
  ---The key name of this Key/State pair.
  ---@field key string
  ---The state of this Key/State pair.
  ---@field state boolean
  ---For internal use.
  ---@field private _json string
  local SheetKeyBoolean = {}
  local SKB_mt = {__index = SheetKeyBoolean}

  ---Create a new Key/State pair.
  ---@param key string
  ---@param state? boolean
  function SheetKeyBoolean:New(key, state)
    return setmetatable({
      key = tostring(key),
      state = state
    }, SKB_mt)
  end

  ---For internal use.
  ---@return SheetKeyBoolean
  function SheetKeyBoolean:Build()
    local state, color
    if self.state == nil then
      state, color = PSLang.s_unk, PSTheme.unk
    else
      state = self.state and PSLang.s_yes or PSLang.s_no
      color = self.state and PSTheme.yes or PSTheme.no
    end
    self._json = json.jobj{
      text = json.qstring(self.key .. ": "),
      color = json.qstring(PSTheme.key),
    } .. "," .. json.jobj{
      text = json.qstring(state),
      color = json.qstring(color)
    }
    return self
  end

  ---For internal use.
  ---@return string
  function SheetKeyBoolean:ToJson()
    if not self._json then self:Build() end
    return self._json
  end

  ---Sets the key of this Key/State pair.
  ---@param key string
  ---@return SheetKeyBoolean
  function SheetKeyBoolean:SetKey(key)
    self.key = tostring(key)
    return self
  end

  ---Sets the state of this Key/State pair.
  ---@param state boolean?
  ---@return SheetKeyBoolean
  function SheetKeyBoolean:SetState(state)
    self.state = state
    return self
  end

  --============================================================================================--

  ---@type SheetKeyValue[]|SheetKeyBoolean[]
  ---@class SKAProxy
  local SKAProxy


  ---@class SheetKeyArray : SKAProxy
  ---For internal use.
  ---@field private _json string
  local SheetKeyArray = {}
  local SKA_mt = {__index = SheetKeyArray}

  ---Create a new Key Array.
  function SheetKeyArray:New()
    return setmetatable({}, SKA_mt)
  end

  ---For internal use.
  ---@return SheetKeyArray
  function SheetKeyArray:Build()
    if #self == 0 then self._json = nil return end
    local KVs = {}
    for _,kv in ipairs(self) do
      KVs[#KVs+1] = kv:ToJson()
    end
    self._json = table.concat(KVs, "," .. json.nl .. ",")
    return self
  end

  ---For internal use.
  ---@return string
  function SheetKeyArray:ToJson()
    if (not self._json) == (#self > 0) then self:Build() end
    return self._json
  end

  ---Add a Key/Value pair to the array.
  ---@param key string
  ---@return SheetKeyValue
  function SheetKeyArray:AddKeyValue(key)
    local O = SheetKeyValue:New(key)
    self[#self+1] = O
    return O
  end

  ---Add a Key/State pair to the array.
  ---@param key string
  ---@param state boolean
  ---@return SheetKeyValue
  function SheetKeyArray:AddKeyBoolean(key, state)
    local O = SheetKeyBoolean:New(key, state)
    self[#self+1] = O
    return O
  end

  --============================================================================================--

  ---@type SheetText[]
  ---@class SLTProxy
  local SLTProxy


  ---@class SheetLongText : SLTProxy
  ---For internal use.
  ---@field private _json string
  local SheetLongText = {}
  local SLT_mt = {__index = SheetLongText}

  ---Create a new Long Text object.
  function SheetLongText:New()
    return setmetatable({}, SLT_mt)
  end

  ---For internal use.
  ---@return SheetLongText
  function SheetLongText:Build()
    if #self == 0 then self._json = nil return end
    local Ts = {}
    for _,text in ipairs(self) do
      Ts[#Ts+1] = text:ToJson()
    end
    self._json = table.concat(Ts, ",")
    return self
  end

  ---For internal use.
  ---@return string
  function SheetLongText:ToJson()
    if (not self._json) == (#self > 0) then self:Build() end
    return self._json
  end

  ---Add a text component to this Long Text object.
  ---@param text? string
  ---@return SheetText
  function SheetLongText:AddText(text)
    local O = SheetText:New(text)
    self[#self+1] = O
    return O
  end

  --============================================================================================--

  ---@class SheetPlayer
  ---The Player's name as a Long Text object.
  ---@field name SheetLongText
  ---The Player's UUID.
  ---@field uuid string?
  ---A KeyArray object for this Player.
  ---@field keyvals SheetKeyArray
  ---The description of this Player as a Long Text object.
  ---@field desc SheetLongText
  ---For internal use.
  ---@field private _json string
  local SheetPlayer = {}
  local SP_mt = {__index = SheetPlayer}

  ---Create a new Player.
  function SheetPlayer:New()
    return setmetatable({
      name = SheetLongText:New(),
      keyvals = SheetKeyArray:New(),
      desc = SheetLongText:New()
    }, SP_mt)
  end

  ---For internal use.
  ---@return SheetPlayer
  function SheetPlayer:Build()
    local parts = {
      (self.name:ToJson() or json.qstring(PSLang.unknown)) .. "," .. json.jobj{
        text = json.qstring(" " .. PSLang.s_mark),
        font = '"figura:default"'
      }
    }
    if self.uuid then
      parts[#parts+1] = json.jobj{
        text = json.qstring(self.uuid),
        color = json.qstring(PSTheme.uuid)
      }
    end
    parts[#parts+1] = self.keyvals:ToJson()
    parts[#parts+1] = self.desc:ToJson()
    self._json = table.concat(parts, "," .. json.nl .. ",")
    return self
  end

  ---For internal use.
  ---@return string
  function SheetPlayer:ToJson()
    if not self._json then self:Build() end
    return self._json
  end

  ---Gets the Long Text object for this Player.
  function SheetPlayer:GetName()
    return self.name
  end

  ---Gets the KeyArray object for this Player.
  function SheetPlayer:GetKeyArray()
    return self.keyvals
  end

  ---Sets the UUID for this player.
  ---@param uuid string?
  ---@return SheetPlayer
  function SheetPlayer:SetUUID(uuid)
    if not uuid then
      self.uuid = nil
      return self
    end
    uuid = tostring(uuid)
    if not uuid:match("^\z
      %x%x%x%x%x%x%x%x%-\z
      %x%x%x%x%-\z
      %x%x%x%x%-\z
      %x%x%x%x%-\z
      %x%x%x%x%x%x%x%x%x%x%x%x\z
    $") then
      error("invalid uuid given", 2)
    end
    self.uuid = uuid
    return self
  end

  ---Gets the Long Text object for this Player.
  function SheetPlayer:GetDesc()
    return self.desc
  end

  --============================================================================================--

  ---@class SheetAvatar
  ---The File Size of this Avatar.
  ---@field filesize number?
  ---The Complexity of this Avatar.
  ---@field complexity number?
  ---The Init instruction count of this Avatar.
  ---@field init number?
  ---The Tick instruction count of this Avatar.
  ---@field tick number?
  ---The Render instruction count of this Avatar.
  ---@field render number?
  ---The Particles/second count of this Avatar.
  ---@field particles number?
  ---The Sounds/second count of this Avatar.
  ---@field sounds number?
  ---The Vanilla Changes state of this Avatar.
  ---@field vanilla boolean?
  ---The Nameplate Changes state of this Avatar.
  ---@field nameplate boolean?
  ---The Offscreen Render state of this Avatar.
  ---@field offscreen boolean?
  ---The Render Layers state of this Avatar.
  ---@field renderlayers boolean?
  ---The Custom Sounds state of this Avatar.
  ---@field customsounds boolean?
  ---The Player Tracking state of this Avatar.
  ---@field tracking boolean?
  ---For internal use.
  ---@field private _trust string
  ---For internal use.
  ---@field private _json string
  local SheetAvatar = {}
  local SA_mt = {__index = SheetAvatar}

  ---Creates an Avatar.
  function SheetAvatar:New()
    return setmetatable({}, SA_mt)
  end

  ---For internal use.
  ---@param key string
  ---@param value string?
  ---@param color? string
  local function imitateKV(key, value, color)
    if not value then
      value, color = PSLang.unknown, PSTheme.unknown
    end
    return json.jobj{
      text = json.qstring(key .. ": "),
      color = json.qstring(PSTheme.key)
    } .. "," .. json.jobj{
      text = json.qstring(value),
      color = json.qstring(color)
    }
  end

  ---For internal use.
  ---@param key string
  ---@param bool boolean?
  local function imitateKB(key, bool)
    local state, color
    if bool == nil then
      state, color = PSLang.s_unk, PSTheme.unk
    else
      state = bool and PSLang.s_yes or PSLang.s_no
      color = bool and PSTheme.yes or PSTheme.no
    end
    return json.jobj{
      text = json.qstring(key .. ": "),
      color = json.qstring(PSTheme.key)
    } .. "," .. json.jobj{
      text = json.qstring(state),
      color = json.qstring(color)
    }
  end

  local trust_limits = {
    complexity = {1152, 3456},
    init = {16384, 16384},
    tick = {4096, 8192},
    render = {1024, 2048},
    particles = {4, 16},
    sounds = {4, 16}
  }

  ---For internal use.
  ---@return SheetAvatar
  function SheetAvatar:DetermineTrust()
    local current = 0
    for n,l in pairs(trust_limits) do
      current = math.max(current,
        ((self[n] or 0) > l[2] and 2) or
        ((self[n] or 0) > l[1] and 1) or
        0
      )
      if current == 2 then break end
    end
    if current == 0 and (
      self.vanilla or
      self.nameplate or
      self.offscreen or
      self.renderlayers or
      self.customsounds
    ) then
      current = 1
    end
    self._trust = imitateKV(
      PSLang.a_trust,
      PSLang["a_trust" .. current],
      PSTheme["trust" .. current]
    )
    return self
  end

  ---For internal use.
  ---@return SheetAvatar
  function SheetAvatar:Build()
    self:DetermineTrust()
    local PSTNumber = PSTheme.number
    local parts = {
      self._trust,
      imitateKV(PSLang.a_filesize, (self.filesize or PSLang.unknown) .. "kb", PSTNumber),
      imitateKV(PSLang.a_complex, self.complexity, PSTNumber),
      imitateKV(PSLang.a_init, self.init, PSTNumber),
      imitateKV(PSLang.a_tick, self.tick, PSTNumber),
      imitateKV(PSLang.a_render, self.render, PSTNumber),
      imitateKV(
        PSLang.a_particles,
        (self.particles == nil and (PSLang.unknown .. "/s")) or
        ((self.particles >= 1) and (math.floor(self.particles*100)*0.01 .. "/s")) or
        ((self.particles == 0) and PSLang.none) or
        ("1/" .. math.floor(1/self.particles*100)*0.01 .. "s"),
        PSTNumber
      ),
      imitateKV(
        PSLang.a_sounds,
        (self.sounds == nil and (PSLang.unknown .. "/s")) or
        ((self.sounds >= 1) and (math.floor(self.sounds*100)*0.01 .. "/s")) or
        ((self.sounds == 0) and PSLang.none) or
        ("1/" .. math.floor(1/self.sounds*100)*0.01 .. "s"),
        PSTNumber
      ),
      imitateKB(PSLang.a_vanilla, self.vanilla),
      imitateKB(PSLang.a_nameplate, self.nameplate),
      imitateKB(PSLang.a_offscreen, self.offscreen),
      imitateKB(PSLang.a_renderlayers, self.renderlayers),
      imitateKB(PSLang.a_customsounds, self.customsounds),
      imitateKB(PSLang.a_tracking, self.tracking)
    }
    self._json = table.concat(parts, "," .. json.nl .. ",")
    return self
  end

  ---For internal use.*
  ---
  ---\* This can be used normally with `nameplate.CHAT.setText(this:ToJson())`  
  ---Be warned of the huge instruction cost of using the Player Sheet object instead of the resulting string.
  ---@return string
  function SheetAvatar:ToJson()
    if not self._json then self:Build() end
    return self._json
  end

  ---Sets the File Size for this Avatar.
  ---@param size number
  ---@return SheetAvatar
  function SheetAvatar:SetFilesize(size)
    self.filesize = math.floor(size*100)/100
    return self
  end

  ---Sets the Complexity for this Avatar.
  ---@param amount number
  ---@return SheetAvatar
  function SheetAvatar:SetComplexity(amount)
    self.complexity = math.floor(amount)
    return self
  end

  ---Sets the Init instruction limit for this Avatar.
  ---@param instructions number
  ---@return SheetAvatar
  function SheetAvatar:SetInit(instructions)
    self.init = math.floor(instructions)
    return self
  end

  ---Sets the Tick instruction limit for this Avatar.
  ---@param instructions number
  ---@return SheetAvatar
  function SheetAvatar:SetTick(instructions)
    self.tick = math.floor(instructions)
    return self
  end

  ---Sets the Render instruction limit for this Avatar.
  ---@param instructions number
  ---@return SheetAvatar
  function SheetAvatar:SetRender(instructions)
    self.render = math.floor(instructions)
    return self
  end

  ---Sets the particles/second limit for this Avatar.
  ---@param amount number
  ---@return SheetAvatar
  function SheetAvatar:SetParticles(amount)
    self.particles = amount
    return self
  end

  ---Sets the sounds/second limit for this Avatar.
  ---@param amount number
  ---@return SheetAvatar
  function SheetAvatar:SetSounds(amount)
    self.sounds = amount
    return self
  end

  ---Sets the Vanilla Changes state for this Avatar.
  ---@param state boolean
  ---@return SheetAvatar
  function SheetAvatar:SetVanillaChanges(state)
    self.vanilla = state
    return self
  end

  ---Sets the Nameplate Changes state for this Avatar.
  ---@param state boolean
  ---@return SheetAvatar
  function SheetAvatar:SetNameplateChanges(state)
    self.nameplate = state
    return self
  end

  ---Sets the Offscreen Rendering state for this Avatar.
  ---@param state boolean
  ---@return SheetAvatar
  function SheetAvatar:SetOffscreenRender(state)
    self.offscreen = state
    return self
  end

  ---Sets the Render Layers state for this Avatar.
  ---@param state boolean
  ---@return SheetAvatar
  function SheetAvatar:SetRenderLayers(state)
    self.renderlayers = state
    return self
  end

  ---Sets the Custom Sounds state for this Avatar.
  ---@param state boolean
  ---@return SheetAvatar
  function SheetAvatar:SetCustomSounds(state)
    self.customsounds = state
    return self
  end

  ---Sets the Player Tracking state for this Avatar.
  ---@param state boolean
  ---@return SheetAvatar
  function SheetAvatar:SetTracking(state)
    self.tracking = state
    return self
  end


  --============================================================================================--

  ---MAKE THIS!
  ---@class PlayerSheet
  ---The player information.
  ---@field player SheetPlayer
  ---The character information.
  ---@field character? SheetKeyArray
  ---The avatar information.
  ---@field avatar? SheetAvatar
  ---For internal use.
  ---@field private _json string
  PlayerSheet = {}
  local PS_mt = {__index = PlayerSheet}

  ---Create a new Player Sheet.  
  ---**START HERE**
  ---@param noCharacter? boolean
  ---@param avatarStats? boolean
  function PlayerSheet:New(noCharacter, avatarStats)
    return setmetatable({
      player = SheetPlayer:New(),
      character = not noCharacter and SheetKeyArray:New() or nil,
      avatar = avatarStats and SheetAvatar:New() or nil
    }, PS_mt)
  end

  ---For internal use.
  ---@return PlayerSheet
  function PlayerSheet:Build()
    local sep = json.jobj{
      text = json.qstring(PSLang.s_hzbar),
      color = json.qstring(PSTheme.hzbar),
      strikethrough = true
    }
    local parts = {
    --====<TITLE>==========--
      json.jobj{
        text = json.qstring(PSLang.title),
        color = json.qstring(PSTheme.title),
        bold = true,
        underlined = true
      },
    --====<PLAYER>=========--
      json.jobj{
        text = json.qstring("[" .. PSLang.l_player .. "]:"),
        color = json.qstring(PSTheme.label0)
      },
      self.player:ToJson()
    }
    --====<CHARACTER>======--
    if self.character then
      parts[#parts+1] = sep
      parts[#parts+1] = json.jobj{
        text = json.qstring("[" .. PSLang.l_char .. "]:"),
        color = json.qstring(PSTheme.label1)
      }
      parts[#parts+1] = self.character:ToJson()
    end
    --====<AVATAR>=========--
    if self.avatar then
      parts[#parts+1] = sep
      parts[#parts+1] = json.jobj{
        text = json.qstring("[" .. PSLang.l_avatar .. "]:"),
        color = json.qstring(PSTheme.label2)
      }
      parts[#parts+1] = self.avatar:ToJson()
    end

    self._json = json.jobj{
      text = '""',
      extra = "[" .. (self.player.name:ToJson() or json.qstring(PSLang.unknown)) .. "," .. json.jobj{
        text = json.qstring(" " .. PSLang.menu),
        color = json.qstring(PSTheme.menu)
      } .. "]",
      hoverEvent = json.jobj{
        action = '"show_text"',
        contents = '["",' .. table.concat(parts, "," .. json.nl .. ",") .. "]"
      }
    }

    return self
  end

  ---For internal use.
  ---@return string
  function PlayerSheet:ToJson()
    if not self._json then self:Build() end
    return self._json
  end

  ---Use this function to export the Player Sheet to the log for copying.  
  ---USE THIS WHEN YOU ARE DONE MAKING THE PLAYER SHEET.
  function PlayerSheet:Grab()
    if not self._json then self:Build() end
    print("[==[" .. self._json .. "]==]")
    print(([[
      {"text":"
        \nThe string for your Player Sheet has been sent to your output log.
        \nCopy the entire Sheet object (everything between the [==[...]==], including the brackets)
        \nand set it as your CHAT nameplate.
        \n
        \nEx:
        \nnameplate.CHAT.setText([==[ . . . ]==])
        \n
        \nOnce you are done, you can remove the Player Sheet generator script.
        \n
        \nA preview of your Player Sheet is shown below.
      ","italic":false}]]):gsub("\n%s+", ""), true)
    print('[{"text":"","italic":false},' .. self._json .. ']', true)
    print("\nBlame Figura for not allowing me to copy text to the clipboard.\nThis could have been easier lmao.")
  end

  ---Gets the Player in this Player Sheet.
  function PlayerSheet:GetPlayer()
    return self.player
  end

  ---Gets the Character in this Player Sheet.
  function PlayerSheet:GetCharacter()
    return self.character
  end

  ---Gets the Avatar in this Player Sheet.
  function PlayerSheet:GetAvatar()
    return self.avatar
  end
end





























---CREATE A NEW SHEET---
local Sheet = PlayerSheet:New()

---ACT ON THE PLAYER'S NAME:---
Sheet.player.name
  :AddText("Username") --ADD A TEXT COMPONENT TO IT.
    :SetColor("#7F7F7F") --MODIFY THE TEXT COMPONENT'S COLOR.

---ACT ON THE PLAYER:---
Sheet.player
  :SetUUID("12345678-1234-1234-1234-123456789abc") --SET THE UUID

---ACT ON THE PLAYER'S KEYARRAY:---
Sheet.player.keyvals
  :AddKeyValue("Years Slept For") --ADD A KEY/VALUE PAIR WITH THE KEY "Years Slept For"
    :GetValue() --GET THE VALUE OF THIS PAIR.
      :SetText("99999999999999999...") --SET THE VALUE OF THE PAIR TO "99999999999999999...".

---ACT ON THE PLAYER'S KEYARRAY:---
Sheet.player.keyvals
  :AddKeyBoolean("Based", true) --ADD A KEY/STATE PAIR WITH THE KEY "Based" WITH THE true STATE.

---ACT ON THE PLAYER'S DESCRIPTION:---
Sheet.player.desc
  :AddText("Some indescribable ") --ADD A TEXT COMPONENT TO IT.
    :SetColor("gray") --MODIFY THE TEXT COMPONENT'S COLOR

---ACT ON THE PLAYER'S DESCRIPTION:---
Sheet.player.desc
  :AddText("horror.") --ADD ANOTHER TEXT COMPONENT TO IT.
    :SetColor("blue") --MODIFY THE TEXT COMPONENT'S COLOR.
    :SetItalic(true) --MAKE THE TEXT COMPONENT ITALICIZED.

---ACT ON THE CHARACTER:---
Sheet.character
  :AddKeyValue("Name") --ADD A KEY/VALUE PAIR WITH THE KEY "Name".
    :GetValue() --GET THE VALUE OF THIS PAIR.
      :SetText("Guy", "#240055") --SET THE VALUE OF THE PAIR TO "Guy" WITH THE COLOR "#240055".

---ACT ON THE CHARACTER:---
Sheet.character
  :AddKeyValue("Species") --ADD A KEY/VALUE PAIR WITH THE KEY "Species".
    :GetValue() --GET THE VALUE OF THIS PAIR.
      :SetText("Crewmate", "red") --SET THE VALUE OF THE PAIR TO "Crewmate" WITH THE COLOR "red".

---ACT ON THE CHARACTER:---
Sheet.character:AddKeyBoolean("Fluffy", true) --ADD A KEY/STATE PAIR WITH THE KEY "Fluffy" WITH THE true STATE.
Sheet.character:AddKeyBoolean("Confused", false) --ADD A KEY/STATE PAIR WITH THE KEY "Confused" WITH THE false STATE.
Sheet.character:AddKeyBoolean("Sus", nil) --ADD a KEY/STATE PAIR WITH THE KEY "Sus" WITH AN UNKNOWN STATE.

---SUBMIT THE PLAYER SHEET AND LOG THE FINISHED STRING TO THE OUTPUT LOG.
---YOU GENERALLY WANT TO USE THIS.
---
---AFTER USING THIS FUNCTION, YOU WILL GET INSTRUCTIONS ON HOW TO USE THE EXPORTED PLAYER SHEET.
Sheet:Grab()





---SUBMIT THE PLAYER SHEET AND DIRECTLY SET IT AS YOUR NAMEPLATE.  
---THIS IS NOT RECOMMENDED BECAUSE IT WILL COST UPWARDS OF 10,000 INSTRUCTIONS
---TO APPLY THE NAMEPLATE.
---
---ONLY USE THIS IF EVERYONE CAN HANDLE THE HUGE INSTRUCTION COST.
nameplate.CHAT.setText(Sheet:ToJson())
