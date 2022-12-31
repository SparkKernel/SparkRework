Server.Users.Events.Handle('Spawn', function(User, Data)
    local coords = Data.coords
    print(json.encode(coords))
    User.Position.Set(
        coords.x,
        coords.y,
        coords.z
    )
end)