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

            return true, "success"
        end
        
        function obj.Clipboard(text)
            if not online() then
                return false, "user_not_online"
            end

            obj.Send({
                type = "clipboard",
                data = text
            })

            return true, "success"
        end
        
        return obj
    end
})