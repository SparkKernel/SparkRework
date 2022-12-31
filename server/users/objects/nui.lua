AddPlayerObject({
    name = 'NUI',
    object = function(steam, player, sql, obj, online, set, get, client)
        function obj.Send(data)
            if not online() then
                return false, "user_not_online"
            end

            client.Event(
                'Sparkling:SendNuiMessage',
                data
            )
        end
        
        obj.Clipboard = {}
        function obj.Clipboard.Set(text)
            if not online() then
                return false, "user_not_online"
            end

            obj.Send({
                type = "clipboard",
                action = "set",
                data = text
            })
        end

        function obj.Clipboard.Get()
            if not online() then
                return false, "user_not_online"
            end

            local CallbackResponse = client.Sync.Callback('getClipboard')
            print(CallbackResponse)
        end
        
        return obj
    end
})