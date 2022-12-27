Server.Users.Players = {}

local Join = Server.Users.Events.Add('Join')
local Connecting = Server.Users.Events.Add('Connecting')
local Drop = Server.Users.Events.Add('Drop')

local Inbuilt = Server.SQL.Inbuilt

AddEventHandler('playerConnecting', function(_, _, def)
    local source = source
    local steam = Server.Identifiers.Steam(source)

    if Server.Users.Players[steam] then
        def.done("Whoops, you are already registered.")
        return print("User is already registered")
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

    Server.Users.Players[steam] = currentData
    print("LOADED DATA: "..json.encode(currentData))
    Connecting.Run(steam, true, 'success')
end)

AddEventHandler('playerDropped', function(reason)
    local source = source

    local steam = Server.Identifiers.Steam(source)

    if Server.Users.Players[steam] == nil then
        return print("User is not registered but left")
    end

    print("WEBHOOk")
    print("SAVING: "..json.encode(Server.Users.Players[steam]))
    Drop.Run(steam, reason)

    Server.Users.Players[steam] = nil

    Inbuilt.UpdatePlayerData(steam, Server.Users.Players[steam])
end)

function Server.Users.GetAllPlayers()
    return Server.Users
end

function Server.Users.Get(identifier)
    if type(identifier) ~= "string" then -- can be a source
        
    else

    end
    
    return function(x)
        print(x)
    end, "success"
end

