Server.Users.Data.Handle('Drop', function(User, Data)
    local x,y,z = User.Position.Get()

    Data['coords'] = {
        x = x,
        y = y,
        z = z
    }

    return Data
end)