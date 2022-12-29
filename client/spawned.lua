AddEventHandler('playerSpawned', function(info)
    TriggerServerEvent('playerSpawn', info)
end)

RegisterCallback('test', function()
    return true
end)