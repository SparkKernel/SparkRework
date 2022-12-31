local Inbuilt = Server.SQL.Inbuilt
local Registered = {}

function AddPlayerObject(data)
    table.insert(Registered, data)
end

function PlayerObject(steam)
    local self = {}

    self.steam = steam
    
    self.player = Server.Users.Players[steam]

    if self.player then
        self.source = self.player.src or 0
    else
        self.source = 0
    end

    self.discord = Server.Identifiers.Discord(self.source)
    self.license = Server.Identifiers.License(self.source)

    self.data = Inbuilt.GetPlayer(steam)

    if not self.data then
        Error("User cannot be found!")
        return false, "invalid_user"
    end

    if self.player ~= nil then
        self.id = self.player.id
    else
        self.id = self.data.id
    end

    if self.player and self.player.src then
        self.endpoint = GetPlayerEndpoint(self.player.src) or nil
    else
        self.endpoint = nil
    end

    function self.Online()
        return self.player ~= nil
    end

    for i,v in pairs(Registered) do
        self[v['name']] = v['object'](
            steam,
            self.player,
            Inbuilt,
            {},
            self.Online,
            function(key, val)
                self.player[key] = val
            end,
            function(key)
                return self.player[key]
            end,
            self['Client']
        )
    end

    return self
end