Server.SQL.Inbuilt = {}

local Sync = Server.SQL.Sync
local Exec = Server.SQL.Execute

function Server.SQL.Inbuilt.GetPlayer(steam)
    local resp = Sync('SELECT * FROM users WHERE steam = ?', {steam})
    if #resp == 0 then
        return false
    else
        return resp[1]
    end
end

function Server.SQL.Inbuilt.GetPlayerById(id)
    local resp = Sync('SELECT * FROM users WHERE id = ?', {id})
    if #resp == 0 then
        return false
    else
        return resp[1]
    end
end

function Server.SQL.Inbuilt.InsertPlayer(steam)
    Sync('INSERT INTO users (steam) VALUES (?)', {steam})
end

function Server.SQL.Inbuilt.UpdatePlayerData(steam, data)
    Exec('UPDATE users SET data = ? WHERE steam = ?', {json.encode(data), steam})
end

function Server.SQL.Inbuilt.CalculateData(user, config, current)
    if user == nil then
        return config
    end
    current = user
    for k,v in pairs(config) do
        if user[k] == nil then
            current[k] = v
        else
            current[k] = user[k]
        end
    end
    return current
end