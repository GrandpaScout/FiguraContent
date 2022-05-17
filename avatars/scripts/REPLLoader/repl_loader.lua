if client.isHost() then
  --[[>======================================<< INFO >>======================================<[]--
      FIGURA REPL <LOADER>
      By: GrandpaScout [STEAM_1:0:55009667]
      Version: 4.1.6
      Compatibility: >= Figura 0.0.8
      Description:
        A REPL for use in Figura 0.0.8 or later.
        Contains formatting for types, table printing, hover data, and many other tools.
        It is also themeable!
  --[]>====================================<< END INFO >>====================================<]]--
  local lastName = data.getName()
  data.setName("LOADERFILE_REPL")
  ---@type string
  local script = data.load("script")

  local s = pcall(loadstring(script or "error()"))
  if not s then print("§r§cLOADER <FIGURA REPL> FAILED: SCRIPT MAY BE CORRUPTED!§r") end
  data.setName(lastName)
end
