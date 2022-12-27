local Spark = Spark()

RegisterCommand("playercoords", function()
  print(Spark.Functions.GetPlayerCoords())
  TriggerEvent('chat:addMessage', {
    color = { 0, 255, 255},
    multiline = true,
    args = {json.encode(Spark.Functions.GetPlayerCoords())}
  })
end)

RegisterCommand("tp", function(source, args)
  if args[1] and not args[2] and not args[3] then
    if tonumber(args[1]) then
      local target = GetPlayerPed(GetPlayerFromServerId(tonumber(args[1])))
      if target ~= 0 then
          print(GetEntityCoords(target))
          Spark.Functions.SetPlayerCoords(GetEntityCoords(target), true)
      end
    end
  else
    if args[1] and args[2] and args[3] then
      local x = tonumber((args[1]:gsub(",",""))) + .0
      local y = tonumber((args[2]:gsub(",",""))) + .0
      local z = tonumber((args[3]:gsub(",",""))) + .0
      Spark.Functions.SetPlayerCoords(vector3(x, y, z), true)
    end
  end
end)

RegisterCommand("notify", function()
  Spark.Functions.NewNotification("Hej", "test")
end)

RegisterCommand("car", function(source, args)
  if not args[1] then return end
  Spark.Functions.SpawnVehicle(args[1])
end)