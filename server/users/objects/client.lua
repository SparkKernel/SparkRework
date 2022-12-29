local Callbacks = {}

local CallbackNames = {}

RegisterNetEvent('Sparkling:AddCallbackName', function(name)
    CallbackNames[name] = true
end)

RegisterNetEvent('Sparkling:ReturnClientCallback', function(id, resp)
    if Callbacks[id] == nil then
        return Error("Cannot find callback id | id: "..id)
    end
    Callbacks[id](resp)
    Callbacks[id] = nil
end)

AddPlayerObject({
    name = 'Client',
    object = function(steam, player, sql, obj, online)
        obj.Sync = {}
        function obj.Event(name, ...)
            if not online() then
                Error("Tried calling event, but user is not online")
                return false, "user_not_online"
            end
            TriggerClientEvent(name, player.src, ...)
        end

        function obj.Callback(name, func, ...)
            if CallbackNames[name] == nil then
                Error("Callback "..name.." does not exist!")
                return false, "invalid_callback"
            end
            if not online() then
                Error("Tried running callback "..name.." but user is not online!")
                return false, "user_not_online"
            end

            local callback = tostring(math.random(1000000, 9999999))
            Callbacks[callback] = func
            obj.Event('Sparkling:TriggerClientCallback', name, callback)
        end

        function obj.Sync.Callback(name, ...)

        end

        return obj
    end
})