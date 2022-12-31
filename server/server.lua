Server = {}

function Spark()
    return Server
end

exports("Spark", Spark)

RegisterCommand('test', function(src)
    local User = Server.Users.Get(src)
    print(User.Position.Set(0,0,0))
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