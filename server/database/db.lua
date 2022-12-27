Server.SQL = {}

local ex = exports['SparkRework']

ex:createConnection(
    DatabaseConfiguration, -- use info from config
    function()
        print("Connected to DB!")
    end,
    function(err)
        print("Cannot connect to db: "..err)
    end
)

function Server.SQL.Query(query, params, cb)
    ex:query(query, params, function(result)
        if result['sqlMessage'] then
            print(json.encode(result))
            print("Error while executing: "..tostring(result['sqlMessage']))
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