Server.Identifiers = {}

function Server.Identifiers.Get(source, identifier)
    if source == 0 then
        return false
    end
    for _,v in pairs(GetPlayerIdentifiers(source)) do
        if string.find(v, identifier..':') then
            return v:gsub(identifier..':', "")
        end
    end
    return false, "no_identifier"
end

function Server.Identifiers.Steam(source) return Server.Identifiers.Get(source, 'steam') end
function Server.Identifiers.License(source) return Server.Identifiers.Get(source, 'license') end
function Server.Identifiers.Discord(source) return Server.Identifiers.Get(source, 'discord') end