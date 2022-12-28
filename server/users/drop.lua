local currentCoords = 123

Server.Users.Data.Handle('Drop', function(data)
    data['coords'] = {
        x = currentCoords,
        y = currentCoords,
        z = currentCoords
    }

    currentCoords = 69

    return data
end)