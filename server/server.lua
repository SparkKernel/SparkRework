Server = {}

function Spark()
    return Server
end

exports("Spark", Spark)

RegisterCommand('test', function(src)
    print(Server.Users.Get(Server.Identifiers.Steam(src)).id)
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