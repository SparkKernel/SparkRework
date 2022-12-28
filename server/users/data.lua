Server.Users.Data = {}
Server.Users.Data.Sets = {}

function Server.Users.Data.Create(name)
    if Server.Users.Data.Sets[name] then return Error("Callback already exists: "..name) end
    Server.Users.Data.Sets[name] = {}

    return function(func, ...)
        for i,v in pairs(Server.Users.Data.Sets[name]) do
            func(v(...))
        end
    end
end

function Server.Users.Data.Handle(name, func)
    if not Server.Users.Data.Sets[name] then return Error("Callback does not exist: "..name) end
    table.insert(Server.Users.Data.Sets[name], func)
end