--==[["GSBone" library by Grandpa Scout (STEAM_1:0:55009667)]]==--                         -<0.1.0>-

local Bone,UpdateAllBones={}
do;local bdf,bl={setPos=true,setRot=true,setScale=true,setEnabled=true},{}
  function Bone:New(pt,dp)
    local nw=self==Bone
    local b=setmetatable({
      _SELF=pt,_READONLY=not nw,_DIRECT_PARENT=not nw and dp or nil,
      _POS=nw and{update=false,did_update=false,layer={},value={0,0,0}}or nil,
      _ANGLE=nw and{update=false,did_update=false,layer={},value={0,0,0}}or nil,
      _SCALE=nw and{update=false,did_update=false,layer={},value={1,1,1}}or nil,
      _DO_UPDATE=pt.getEnabled()
    },{__index=self})
    for n,v in pairs(pt)do;if type(v)=="function"and not bdf[n]then;b[n]=v;end;end
    local cr=pt.getRot()
    if not(cr[1]==0 and cr[2]==0 and cr[3]==0)then;b._ANGLE.layer._bb={cr[1],cr[2],cr[3]};end
    bl[#bl+1]=b;return b
  end
  function Bone:SetEnabled(s)self._DO_UPDATE=s;self._SELF.setEnabled(s)end
  function Bone:SetPos(lr,v)
    if self._READONLY then error("This Bone inherits and is read-only!",2)end
    local lt=self._POS.layer[lr]
    if not lt then;self._POS.layer[lr]={}lt = self._POS.layer[lr]end
    if not self._POS.update then
      if lt[1]~=v[1]then lt[1],self._POS.update=v[1],true end
      if lt[2]~=v[2]then lt[2],self._POS.update=v[2],true end
      if lt[3]~=v[3]then lt[3],self._POS.update=v[3],true end
    else lt[1],lt[2],lt[3]=v[1],v[2],v[3]end;self._DO_UPDATE=true
  end
  function Bone:SetRot(lr,v)
    if self._READONLY then error("This Bone inherits and is read-only!",2)end
    local lt=self._ANGLE.layer[lr]
    if not lt then;self._ANGLE.layer[lr]={}lt=self._ANGLE.layer[lr]end
    if not self._ANGLE.update then
      if lt[1]~=v[1]then lt[1],self._ANGLE.update=v[1],true end
      if lt[2]~=v[2]then lt[2],self._ANGLE.update=v[2],true end
      if lt[3]~=v[3]then lt[3],self._ANGLE.update=v[3],true end
    else lt[1],lt[2],lt[3]=v[1],v[2],v[3]end;self._DO_UPDATE=true
  end
  function Bone:SetScale(lr,v)
    if self._READONLY then error("This Bone inherits and is read-only!",2)end
    local lt=self._SCALE.layer[lr]
    if not lt then;self._SCALE.layer[lr]={}lt=self._SCALE.layer[lr]end
    if not self._SCALE.update then
      if lt[1]~=v[1]then lt[1],self._SCALE.update=v[1],true end
      if lt[2]~=v[2]then lt[2],self._SCALE.update=v[2],true end
      if lt[3]~=v[3]then lt[3],self._SCALE.update=v[3],true end
    else lt[1],lt[2],lt[3]=v[1],v[2],v[3]end;self._DO_UPDATE=true
  end
  function Bone:DelPos(l)self._POS.layer[l]=nil end
  function Bone:DelRot(l)self._ANGLE.layer[l]=nil end
  function Bone:DelScale(l)self._SCALE.layer[l]=nil end
  function Bone:Update()
    if self._READONLY then
      if self._ANGLE.did_update then self._SELF.setRot(self._ANGLE.value)end
      if not self._DIRECT_PARENT then
        if self._POS.did_update then self._SELF.setPos(self._POS.value)end
        if self._SCALE.did_update then self._SELF.setScale(self._SCALE.value)end
      end
    else
      self._POS.did_update,self._ANGLE.did_update,self._SCALE.did_update=false,false,false
      if not self._DO_UPDATE then return end
      local t,x,y,z
      if self._POS.update then
        t,x,y,z=self._POS,0,0,0;for _,v in pairs(t.layer)do;x,y,z=x+v[1],y+v[2],z+v[3]end
        t.update,t.did_update,t.value=false,true,{x,y,z}self._SELF.setPos(t.value)
      end
      if self._ANGLE.update then
        t,x,y,z=self._ANGLE,0,0,0;for _,v in pairs(t.layer)do;x,y,z=x+v[1],y+v[2],z+v[3]end
        t.update,t.did_update,t.value=false,true,{x,y,z}self._SELF.setRot(t.value)
      end
      if self._SCALE.update then
        t,x,y,z=self._SCALE,1,1,1;for _,v in pairs(t.layer)do;x,y,z=x*v[1],y*v[2],z*v[3]end
        t.update,t.did_update,t.value=false,true,{x,y,z}self._SELF.setScale(t.value)
      end
    end
  end
  function UpdateAllBones(of)for _,b in ipairs(of or bl)do;b:Update()end;end
end
local LIB_GSBONE = "0.1.0"
