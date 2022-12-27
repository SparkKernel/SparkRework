Server.Users = {}
Server.Users.Events = {}

local CurrentEvents = {}

function Server.Users.Events.Add(name)
    if CurrentEvents[name] ~= nil then return Error("Event already exists") end
    CurrentEvents[name] = {}
    return {
        Run = function(...)
            for i,v in pairs(CurrentEvents[name]) do
                v(...)
            end
        end
    }
end

function Server.Users.Events.Handle(name, func)
    if CurrentEvents[name] == nil then return Error("Event does not exist") end
    table.insert(CurrentEvents[name], func)
end