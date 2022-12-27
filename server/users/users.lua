Server.Users.Players = {}

local Join = Server.Users.Events.Add('Join')
local Connecting = Server.Users.Events.Add('Connecting')
local Drop = Server.Users.Events.Add('Drop')

local Inbuilt = Server.SQL.Inbuilt

local LoadDelay = 30

local NonSaving = {
    "connecting",
    "id"
}

AddEventHandler('playerConnecting', function(_, _, def)
    local source = source
    local steam = Server.Identifiers.Steam(source)

    if Server.Users.Players[steam] then
        def.done("Whoops, you are already registered.")
        return Warn("User is already registered but joined! user: "..steam)
    end

    def.defer()
    Wait(0)

    def.update("Checking your data!")

    local currentData = {}

    if not steam then
        def.done("You are not connected to steam.")
        return Connecting.Run(nil, false, 'not_connected_to_steam')
    end

    def.done()

    local data = Inbuilt.GetPlayer(steam)
    if #data == 0 then
        Inbuilt.InsertPlayer(steam)
        data, currentData = Inbuilt.GetPlayer(steam), PlayerConfiguration
    else
        currentData = Inbuilt.CalculateData(json.decode(data.data), PlayerConfiguration, currentData)
    end

    currentData['connecting'] = true
    currentData['id'] = data.id

    Server.Users.Players[steam] = currentData
    Debug("Loaded data for user "..steam..": "..json.encode(currentData))
    Connecting.Run(steam, true, 'success')

    Wait(LoadDelay*1000)
    if Server.Users.Players[steam] and Server.Users.Players[steam].connecting == true then
        DropPlayer(source, 'Waited to long to load!')
    end
end)

RegisterNetEvent('playerSpawn', function()
    local source = source
    local steam = Server.Identifiers.Steam(source)

    if not steam then
        DropPlayer(source, "Whoops, you spawned without a steam-hex")
        return Error("Cannot find steam of user! user: "..steam)
    end

    if not Server.Users.Players[steam] then
        return Error("User with spawned, but is not registered! user: "..steam)
    end

    Debug("User spawned! user: "..steam)

    Server.Users.Players[steam].connecting = false
end)

AddEventHandler('playerDropped', function(reason)
    local source = source
    local steam = Server.Identifiers.Steam(source)

    if Server.Users.Players[steam] == nil then
        return Warn("User is not registered but left! user: "..steam)
    end

    local data = Server.Users.Players[steam]

    for i,v in pairs(NonSaving) do
        data[v] = nil
    end

    Debug("Saving data for user "..steam..": "..json.encode(data))
    Drop.Run(steam, reason)

    Server.Users.Players[steam] = nil

    Inbuilt.UpdatePlayerData(steam, Server.Users.Players[steam])
end)

function Server.Users.GetAllPlayers()
    return Server.Users.Players
end

function Server.Users.Get(identifier)
    if type(identifier) ~= "string" then -- can be a source
        
    else

    end
    
    return function(x)
        
    end, "success"
end
