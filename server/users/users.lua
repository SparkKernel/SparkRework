Server.Users.Players = {}

local Spawn = Server.Users.Events.Add('Spawn')
local Connecting = Server.Users.Events.Add('Connecting')
local Drop = Server.Users.Events.Add('Drop')

local DropData = Server.Users.Data.Create('Drop')

local Inbuilt = Server.SQL.Inbuilt

local LoadDelay = 60

local NonSaving = {
    "connecting",
    "id",
    "src"
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

    if not steam then
        def.done("You are not connected to steam.")
        return Connecting.Run(nil, false, 'not_connected_to_steam')
    end

    def.done()
    local currentData = {}


    local data = Inbuilt.GetPlayer(steam)
    if #data == 0 then
        Inbuilt.InsertPlayer(steam)
        data = Inbuilt.GetPlayer(steam)
        currentData = PlayerConfiguration
    else
        currentData = Inbuilt.CalculateData(json.decode(data.data), PlayerConfiguration, currentData)
    end

    currentData['connecting'] = true
    currentData['id'] = tostring(data['id'])
    print(json.encode(Server.Users.Players[steam] or {}))
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

    Debug("Current all user data: "..json.encode(Server.Users.Players))
    Debug("Steam of user: "..steam)
    Debug("User id found: "..Server.Users.Players[steam].id or 'undefined')

    if not steam then
        DropPlayer(source, "Whoops, you spawned without a steam-hex")
        return Error("Cannot find steam of user! user: "..steam)
    end

    if not Server.Users.Players[steam] then
        return Error("User spawned, but is not registered! user: "..steam)
    end

    if not Server.Users.Players[steam].connecting then
        return Error("User spawned, but is already connected - prob... died! user: "..steam)
    end

    Debug("User spawned! user: "..steam)

    Spawn.Run(steam)


    Server.Users.Players[steam].connecting = false
    Server.Users.Players[steam].src = source
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

    DropData(function(d)
        data = d
    end, data)

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
