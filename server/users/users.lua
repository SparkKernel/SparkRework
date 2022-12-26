Server.Users = {}

---@return table
function Server.Users.GetAllPlayers()
    return GetPlayers()
end

---@return function
function Server.Users.Get(identifier)
    if type(identifier) ~= "string" then
        return false, "identifier_not_string"
    end
end