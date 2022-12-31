Server = {}

function Spark()
    return Server
end

exports("Spark", Spark)

RegisterCommand('test', function(src)
    local User = Server.Users.Get(src)
    local Has = User.NUI.Clipboard('bob')
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
    Wait(300)
    TriggerEvent('playerSpawn',
        source
    )
end)

RegisterCommand('save', function(source)
    TriggerEvent('playerDropped',
        source
    )
end)