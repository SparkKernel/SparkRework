Server.SQL = {}

local ex = exports['SparkRework']

ex:createConnection(
    DatabaseConfiguration, -- use info from config
    function()
        Success("Connected to DB!", "SparkDB")
    end,
    function(err)
        Error("Cannot connect to DB | code: "..err.code.." address: "..err.address.." port: "..err.port.." errno: "..err.errno, "SparkDB")
    end
)

function Server.SQL.Query(query, params, cb)
    ex:query(query, params, function(result)
        if result['sqlMessage'] then
            Error("Error while executing query! "..tostring(result['sqlMessage']))
            cb(false)
        else
            cb(result)
        end
    end)
end

function Server.SQL.Sync(query, params)
    local p = promise.new()
    Server.SQL.Query(query, params, function(result)
        if result ~= false then
            p:resolve(result)
        end
    end)

    return Citizen.Await(p)
end

function Server.SQL.Execute(query, param)
    Server.SQL.Query(query, param, function() end)
end