Server.Users.Data = {}
Server.Users.Data.Sets = {}

function Server.Users.Data.Create(name)
    if Server.Users.Data.Sets[name] then
        Error("Callback already exists: "..name)
        return false, "callback_already_exists"
    end
    Server.Users.Data.Sets[name] = {}

    return function(func, ...)
        for i,v in pairs(Server.Users.Data.Sets[name]) do
            func(v(...))
        end
    end
end

function Server.Users.Data.Handle(name, func)
    if not Server.Users.Data.Sets[name] then
        Error("Callback does not exist: "..name)
        return false, "callback_does_not_exist"
    end
    table.insert(Server.Users.Data.Sets[name], func)
end