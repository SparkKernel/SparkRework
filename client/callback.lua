local Callbacks = {}

function RegisterCallback(name, func)
    if Callbacks[name] ~= nil then
        Error("Callback already exists")
        return false, "callback_already_exists"
    end
    Callbacks[name] = func
    TriggerServerEvent("Sparkling:AddCallbackName", name)
end

RegisterNetEvent("Sparkling:TriggerClientCallback", function(name, callbackId, ...)
    if Callbacks[name] == nil then
        Error("Callback does not exist")
        return false, "invalid_callback"
    end
    print("RUN")
    local resp = Callbacks[name](...)
    TriggerServerEvent("Sparkling:ReturnClientCallback", callbackId, resp)
end)