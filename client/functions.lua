Client.Functions = {}

Client.Functions.GetPlayerCoords = function()
  return GetEntityCoords(PlayerPedId())
end

Client.Functions.SetPlayerCoords = function(coords, keepVeh)
  if keepVeh then
    return SetPedCoordsKeepVehicle(PlayerPedId(), coords)
  end
  SetEntityCoords(PlayerPedId(), coords)
end

Client.Functions.NewNotification = function(text, type, duration)
  if not text then return end
  type = type or "Normal"
  duration = tonumber(duration) or 3000
  -- SendNUIMessage({
  --   type = "notification",
  --   text = text,
  --   noti_type = type,
  --   duration = duration,
  -- })
end

Client.Functions.SpawnVehicle = function(veh)
  local vehHash = GetHashKey(veh)
  local playerPed = PlayerPedId()
  if not IsModelInCdimage(vehHash) then return Client.Functions.NewNotification(veh.." er ikke et gyldigt køretøj!", "Error") end
  RequestModel(vehHash)
  while not HasModelLoaded(vehHash) do
    Citizen.Wait(10)
  end
  local vehPedIsIn = GetVehiclePedIsIn(playerPed, false)
  if vehPedIsIn and GetPedInVehicleSeat(vehPedIsIn, -1) == playerPed then
    DeleteEntity(vehPedIsIn)
  end
  local spawnedVeh = CreateVehicle(vehHash, GetEntityCoords(playerPed), GetEntityHeading(playerPed), true, false)
  SetPedIntoVehicle(playerPed, spawnedVeh, -1)
  SetModelAsNoLongerNeeded(vehHash)
end