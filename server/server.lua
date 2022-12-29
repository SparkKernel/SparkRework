Server = {}

function Spark()
    return Server
end

exports("Spark", Spark)

RegisterCommand('test', function(src)
    local user = Server.Users.Get(Server.Identifiers.Steam(src))
    user.Client.Callback("test", function(resp)
        print(resp)
    end)
end)

RegisterCommand('load', function(source)
    TriggerEvent('playerConnecting',
        source,
        '',
        {
            defer = function() end,
            update = function() end,
            done = function() end
        }
    )
end)