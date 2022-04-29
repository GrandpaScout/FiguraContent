do local HB = {}
  HB.base = model.health_bar
  HB.pivot = HB.base.health_bar_pivot
  HB.back = HB.pivot.back
  HB.flash = HB.pivot.flash
  HB.color = HB.pivot.color
  HB.targetScale = 1
  HB.lastScale = 1
  HB.flashTimer = -1
  HB.offset = vectors.of{0, -35, 0}
  HB.speed = 1/32

  HB.base.setParentType("WORLD")
  HB.pivot.setParentType("Camera")

  local health, Ohealth = 1, 1
  local HSV = {1/3, 1, 1}
  local Scale = {1, 1, 1}

  function player_init()
    HB.color.setColor({0,1,0})
  end

  function tick()
    Ohealth, health = health, player.getHealthPercentage()
    if health ~= Ohealth then
      HB.targetScale = math.clamp(health, 0, 1)
      HSV[1] = HB.targetScale/3
      Scale[1] = HB.targetScale
      HB.color.setColor(vectors.hsvToRGB(HSV))
      HB.color.setScale(Scale)
      if HB.targetScale >= HB.lastScale then
        HB.flash.setScale(Scale)
        HB.lastScale = HB.targetScale
      end
    end
  end

  local RenderScale = {1, 1, 1}
  function render(delta)
    HB.base.setPos(vectors.worldToPart(player.getPos(delta)) + HB.offset)
    if HB.targetScale ~= HB.lastScale then
      if (HB.lastScale - HB.targetScale) < 0.01 then
        HB.lastScale = HB.targetScale
      else
        HB.lastScale = HB.lastScale - (HB.lastScale - HB.targetScale)*HB.speed
      end
      RenderScale[1] = HB.lastScale
      HB.flash.setScale(RenderScale)
    end
  end
end
