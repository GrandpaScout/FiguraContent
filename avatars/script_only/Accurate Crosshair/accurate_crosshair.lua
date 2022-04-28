if client.isHost() then
  --[[>======================================<< INFO >>======================================<[]--
      FIGURA ACCURATE CROSSHAIR
      By: GrandpaScout [STEAM_1:0:55009667]
      Version: 2.0.0
      Compatibility: >= Figura 0.0.8
      Description:
        A script that automatically adjusts the crosshair to point wherever the player would
        actually hit.
        This allows the player's camera to be moved without the crosshair becoming useless due
        to not actually pointing where the player will hit anymore.
        Automatically supports scaling mods, rescaling will not be considered moving the
        camera and all calculations will be done from the proper eye height of the player.
  --[]>====================================<< END INFO >>====================================<]]--

  --==[[CONFIG]]==--

  ---What to do if nothing is found.
  ---"center" will place the crosshair at the center of your screen
  ---"forward" will place the crosshair 6 blocks ahead of your hit direction.
  ---If the setting is invalid, it will default to "forward"
  ---@type "center"|"forward"
  local nothing_behavior = "forward"

  --==[[||||||]]==--

  ---@type Vector
  local VECTOR_ZERO, VECTOR_CENTER = vectors.of{}, vectors.of{0,0,2}
  local screenpos, crosspos = VECTOR_CENTER, VECTOR_ZERO
  ---@type Vector2
  local screensize = client.getScaledWindowSize() * 0.5
  local player_eyeh = 1.62
  ---@type VectorPos
  local ray_start, ray_end

  function tick()
    screensize = client.getScaledWindowSize() * 0.5 --Crosshair coordinates seem to be twice as sensitive.
    player_eyeh = player.getEyeHeight() --Here's your scale mod support.
  end

  function world_render(delta)
    ray_start = player.getPos(delta)
    ray_start[2] = ray_start[2] + player_eyeh
    ray_end = ray_start + player.getLookDir()*6

    local blockray = renderer.raycastBlocks(ray_start, ray_end, "OUTLINE", "NONE")
    local entityray = renderer.raycastEntities(ray_start, ray_end, function(entity)
      return entity.getUUID() ~= player.getUUID()
    end)

    if not (blockray or entityray) then
      if nothing_behavior == "center" then
        screenpos, crosspos = VECTOR_CENTER, VECTOR_ZERO
      else
        screenpos = vectors.worldToScreenSpace(ray_end)
        crosspos = screenpos * screensize
      end
    elseif not entityray then
      screenpos = vectors.worldToScreenSpace(blockray.pos)
      crosspos = screenpos * screensize
    elseif not blockray then
      screenpos = vectors.worldToScreenSpace(entityray.pos)
      crosspos = screenpos * screensize
    else
      screenpos = vectors.worldToScreenSpace(
        ((blockray.pos - ray_start).getLength() < (entityray.pos - ray_start).getLength())
        and blockray.pos
         or entityray.pos
      )
      crosspos = screenpos * screensize
    end

    client.setCrosshairEnabled(screenpos.z > 1) --Disable the crosshair if it is behind the player.
    client.setCrosshairPos(crosspos)
  end
end
