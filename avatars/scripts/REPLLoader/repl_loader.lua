if client.isHost() then
  --[[>======================================<< INFO >>======================================<[]--
      FIGURA REPL <LOADER>
      By: GrandpaScout [STEAM_1:0:55009667]
      Version: 4.2.0
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

  local s, e = pcall(loadstring(script or [[error("No file exists!")]]))
  if not s then print("§cLOADER <FIGURA REPL> FAILED: SCRIPT MAY BE CORRUPTED!§r\n" .. tostring(e)) end
  data.setName(lastName)
end
