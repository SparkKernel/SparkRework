Server = {}

function Spark()
    return Server
end

exports("Spark", Spark)

RegisterCommand('test', function(src)
    local User = Server.Users.Get(src)
    User.Groups.Add('admin')
    local Has,err = User.Groups.Permission('admin.ban')
    print(Has,err)
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