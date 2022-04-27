--==[["GSBone" library by Grandpa Scout (STEAM_1:0:55009667)]]==--                         -<0.1.0>-

---A custom bone implementation that allows multiple layers of functions to affect the properties of
---a bone without overwriting eachother.
---@class Bone
---The tracked bone.  
---It is not recommended to change this.
---@field private _SELF CustomModelPart
---If this bone is read-only.  
---Do not change this.
---@field private _READONLY boolean
---If this Bone is inheriting its direct parent.
---It is not recommended to change this.
---@field private _DIRECT_PARENT boolean|nil
---Handles position information of the bone.  
---Do not touch unless you know what you are doing.
---@field private _POS table
---Handles angle information of the bone.  
---Do not touch unless you know what you are doing.
---@field private _ANGLE table
---Handles scale information of the bone.  
---Do not touch unless you know what you are doing.
---@field private _SCALE table
---If this bone should even update.
---@field private _DO_UPDATE boolean
---@field getColor function
---@field getEnabled function
---@field getHidden function
---@field getMimicMode function
---@field getOpacity function
---@field getParentType function
---@field getPivot function
---@field getPos function
---@field getRot function
---@field getScale function
---@field getShader function
---@field getUV function
---@field partToWorldDir function
---@field partToWorldPos function
---@field setColor function
---@field setEnabled function
---@field setMimicMode function
---@field setOpacity function
---@field setParentType function
---@field setShader function
---@field setUV function
---@field worldToPartDir function
---@field worldToPartPos function
local Bone = {}
---@diagnostic disable-next-line: unused-local
local UpdateAllBones
do
  local bone_deniedfuncs = {setPos = true, setRot = true, setScale = true, setEnabled = true}
  local bone_list = {}

  ---`direct_parent: boolean`  
  ---&emsp;If the created Bone inherits from another Bone, the position and scale of the bones will
  ---not be set to avoid multiplying positions and scales if this parameter is true.
  ---***
  ---Creates a new Bone.
  ---
  ---If an already existing Bone calls this method, the returned Bone will be read-only and will
  ---copy the Bone that called the method.
  ---@param self Bone
  ---@param part CustomModelPart
  ---@param direct_parent? boolean
  ---@return Bone
  function Bone:New(part, direct_parent)
    local new = self == Bone
    ---@type Bone
    local thisbone = setmetatable({
      _SELF = part,
      _READONLY = not new,
      _DIRECT_PARENT = not new and direct_parent or nil,
      _POS = new and {update = false, did_update = false, layer = {}, value = {0, 0, 0}} or nil,
      _ANGLE = new and {update = false, did_update = false, layer = {}, value = {0, 0, 0}} or nil,
      _SCALE = new and {update = false, did_update = false, layer = {}, value = {1, 1, 1}} or nil,
      _DO_UPDATE = part.getEnabled()
    }, {__index = self})
    for n,v in pairs(part) do
      if type(v) == "function" and not bone_deniedfuncs[n] then
        thisbone[n] = v
      end
    end

    ---@type VectorAng
    local cr = part.getRot()
    if not (cr[1] == 0 and cr[2] == 0 and cr[3] == 0) then
      thisbone._ANGLE.layer._bb = {cr[1], cr[2], cr[3]}
    end
    bone_list[#bone_list+1] = thisbone
    return thisbone
  end

  ---Toggles the visibility of the bone.
  ---@param state boolean
  function Bone:SetEnabled(state)
    self._DO_UPDATE = state
    self._SELF.setEnabled(state)
  end

  ---Sets the position of the bone on the specified layer.
  ---@param layer string
  ---@param pos VectorPos|table
  function Bone:SetPos(layer, pos)
    if self._READONLY then error("This Bone inherits and is read-only!", 2) end
    local lt = self._POS.layer[layer]
    if not lt then
      self._POS.layer[layer] = {}
      lt = self._POS.layer[layer]
    end
    if not self._POS.update then
      if lt[1] ~= pos[1] then lt[1], self._POS.update = pos[1], true end
      if lt[2] ~= pos[2] then lt[2], self._POS.update = pos[2], true end
      if lt[3] ~= pos[3] then lt[3], self._POS.update = pos[3], true end
    else lt[1], lt[2], lt[3] = pos[1], pos[2], pos[3] end
    self._DO_UPDATE = true
  end

  ---Sets the rotation of the bone on the specified layer.
  ---@param layer string
  ---@param ang VectorAng|table
  function Bone:SetRot(layer, ang)
    if self._READONLY then error("This Bone inherits and is read-only!", 2) end
    local lt = self._ANGLE.layer[layer]
    if not lt then
      self._ANGLE.layer[layer] = {}
      lt = self._ANGLE.layer[layer]
    end
    if not self._ANGLE.update then
      if lt[1] ~= ang[1] then lt[1], self._ANGLE.update = ang[1], true end
      if lt[2] ~= ang[2] then lt[2], self._ANGLE.update = ang[2], true end
      if lt[3] ~= ang[3] then lt[3], self._ANGLE.update = ang[3], true end
    else lt[1], lt[2], lt[3] = ang[1], ang[2], ang[3] end
    self._DO_UPDATE = true
  end

  ---Sets the scale of the bone on the specified layer.  
  ---Scale is *not* additive, it is multiplicative.
  ---@param layer string
  ---@param scale VectorPos|table
  function Bone:SetScale(layer, scale)
    if self._READONLY then error("This Bone inherits and is read-only!", 2) end
    local lt = self._SCALE.layer[layer]
    if not lt then
      self._SCALE.layer[layer] = {}
      lt = self._SCALE.layer[layer]
    end
    if not self._SCALE.update then
      if lt[1] ~= scale[1] then lt[1], self._SCALE.update = scale[1], true end
      if lt[2] ~= scale[2] then lt[2], self._SCALE.update = scale[2], true end
      if lt[3] ~= scale[3] then lt[3], self._SCALE.update = scale[3], true end
    else lt[1], lt[2], lt[3] = scale[1], scale[2], scale[3] end
    self._DO_UPDATE = true
  end

  ---Completely removes this position layer from the bone.
  ---@param layer string
  function Bone:DelPos(layer) self._POS.layer[layer] = nil end

  ---Completely removes this rotation layer from the bone.
  ---@param layer string
  function Bone:DelRot(layer) self._ANGLE.layer[layer] = nil end

  ---Completely removes this scale layer from the bone.
  ---@param layer string
  function Bone:DelScale(layer) self._SCALE.layer[layer] = nil end

  ---Sends any updates this bone has to the `CustomModelPart` it is attached to.  
  ---You should only need to do this once per cycle.
  function Bone:Update()
    if self._READONLY then
      if self._ANGLE.did_update then self._SELF.setRot(self._ANGLE.value) end
      if not self._DIRECT_PARENT then
        if self._POS.did_update then self._SELF.setPos(self._POS.value) end
        if self._SCALE.did_update then self._SELF.setScale(self._SCALE.value) end
      end
    else
      self._POS.did_update, self._ANGLE.did_update, self._SCALE.did_update = false, false, false
      if not self._DO_UPDATE then return end
      local this, x, y, z
      if self._POS.update then
        this, x, y, z = self._POS, 0, 0, 0
        for _,v in pairs(this.layer) do
          x, y, z = x + v[1], y + v[2], z + v[3]
        end
        this.update, this.did_update = false, true
        this.value = {x, y, z}
        self._SELF.setPos(this.value)
      end
      if self._ANGLE.update then
        this, x, y, z = self._ANGLE, 0, 0, 0
        for _,v in pairs(this.layer) do
          x, y, z = x + v[1], y + v[2], z + v[3]
        end
        this.update, this.did_update = false, true
        this.value = {x, y, z}
        self._SELF.setRot(this.value)
      end
      if self._SCALE.update then
        this, x, y, z = self._SCALE, 1, 1, 1
        for _,v in pairs(this.layer) do
          x, y, z = x * v[1], y * v[2], z * v[3]
        end
        this.update, this.did_update = false, true
        this.value = {x, y, z}
        self._SELF.setScale(this.value)
      end
    end
  end

  ---`of: Bone[]`  
  ---&emsp;An array of bones you want to update.
  ---***
  ---Sends updates to all or selected bones.
  ---@param of? Bone[]
  ---@diagnostic disable-next-line: unused-local
  function UpdateAllBones(of)
    for _,b in ipairs(of or bone_list) do
      b:Update()
    end
  end
end
---Lets other scripts know that this has loaded in if they depend on it.
---@diagnostic disable-next-line: unused-local
local LIB_GSBONE = "0.1.0"
