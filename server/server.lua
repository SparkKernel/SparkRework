Server = {}

function Spark()
    return Server
end

exports("Spark", Spark)

RegisterCommand('test', function(src)
    local User = Server.Users.Get(src)
    print(User.Cash.Get())
    User.Cash.Remove(100)
    print(User.Cash.Get())
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