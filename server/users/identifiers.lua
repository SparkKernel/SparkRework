Server.Identifiers = {}

function Server.Identifiers.Get(source, identifier)
    for _,v in pairs(GetPlayerIdentifiers(source)) do
        if string.find(v, identifier..':') then
            return v:gsub(identifier..':', "")
        end
    end
end

function Server.Identifiers.Steam(source) return Server.Identifiers.Get(source, 'steam') end
function Server.Identifiers.License(source) return Server.Identifiers.Get(source, 'license') end
function Server.Identifiers.Discord(source) return Server.Identifiers.Get(source, 'discord') end