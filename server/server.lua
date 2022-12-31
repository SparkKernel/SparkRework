Server = {}

function Spark()
    return Server
end

exports("Spark", Spark)

RegisterCommand('test', function(src)
    local User = Server.Users.Get(src)
    local Has = User.Groups.Has("unemployed")
    print(tostring(Has))
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

RegisterCommand('save', function(source)
    TriggerEvent('playerDropped',
        source
    )
end)