Server.Users.Players = {}
Server.Users.PlayersFromId = {}

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

AddEventHandler('playerConnecting', function(src, _, def)
    local source = source
    if tonumber(src) then source = src end
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
    local currentData

    local data = Inbuilt.GetPlayer(steam)

    local copy = {}
    for j,x in pairs(PlayerConfiguration) do copy[j] = x end

    if not data then
        currentData = copy
        Inbuilt.InsertPlayer(steam)
        data = Inbuilt.GetPlayer(steam)
    else
        currentData = Inbuilt.CalculateData(json.decode(data.data), copy, currentData)
    end
    
    currentData['src'] = source
    currentData['connecting'] = true
    currentData['id'] = tostring(data['id'])

    Server.Users.Players[steam] = currentData
    Server.Users.PlayersFromId[data.id] = steam

    Debug("Loaded data for user "..steam..": "..json.encode(currentData))
    Connecting.Run(steam, true, 'success')
end)

RegisterNetEvent('playerSpawn', function()
    local source = source
    local steam = Server.Identifiers.Steam(source)

    if not steam then
        DropPlayer(source, "Whoops, you spawned without a steam-hex")
        return Error("Cannot find steam of user! user: "..tostring(steam))
    end

    if not Server.Users.Players[steam] then
        return Error("User spawned, but is not registered! user: "..steam)
    end

    if not Server.Users.Players[steam].connecting then
        return Error("User spawned, but is already connected - prob... died! user: "..steam)
    end

    Debug("User spawned! user: "..steam)

    Spawn.Run(PlayerObject(steam))

    Server.Users.Players[steam].connecting = false
    Server.Users.Players[steam].src = source
end)

AddEventHandler('playerDropped', function(reason)
    local source = source
    if tonumber(reason) then source = reason end
    local steam = Server.Identifiers.Steam(source)

    if Server.Users.Players[steam] == nil then
        return Warn("User is not registered but left! user: "..steam)
    end

    local data = Server.Users.Players[steam]

    Server.Users.PlayersFromId[data.id] = nil

    for i,v in pairs(NonSaving) do
        data[v] = nil
    end

    DropData(function(d)
        data = d
    end, data)

    Debug("Saving data for user "..steam..": "..json.encode(data))
    Drop.Run(PlayerObject(steam), reason)

    Server.Users.Players[steam] = nil

    Inbuilt.UpdatePlayerData(steam, data)
end)

function Server.Users.GetAllPlayers()
    return Server.Users.Players
end

function Server.Users.Get(identifier, cb)
    local steam
    if type(identifier) ~= "string" then -- can be a source
        steam = Server.Identifiers.Steam(identifier)
        if not steam then return Error("Cannot find getted user") end
    else
        if tonumber(identifier) then
            if not Server.Users.PlayersFromId[identifier] and not cb then
                local user = Inbuilt.GetPlayerById(identifier)
                if not user then
                    return Error("Cannot find user!")
                end
                steam = user.steam
            elseif Users.FromId[source] and not callback then
                steam = Server.Users.PlayersFromId[identifier]
            else
                local user = Inbuilt.GetPlayerById(identifier)
                if not user then return Error("Cannot find user!") end
                cb(PlayerObject(user.steam))
                return
            end
        else
            steam = identifier
        end
    end
    
    return PlayerObject(steam)
end
