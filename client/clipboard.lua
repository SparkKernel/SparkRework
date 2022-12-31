local clipboard = nil

RegisterCallback('getClipboard', function()
    SendNuiMessage({
        type = "clipboard",
        action = "get"
    })

    while clipboard == nil do
        Wait(1)
    end
    
    local copy = clipboard
    clipboard = nil
    return copy
end)

RegisterNUICallback('setClipboard', function(data,cb)
    clipboard = data.text
    cb()
end)