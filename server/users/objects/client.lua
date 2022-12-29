local Callbacks = {}

AddPlayerObject({
    name = 'test',
    object = function(steam, player, sql, obj)
        obj.Sync = {}
        function obj.Event(name, ...)
            TriggerClientEvent(name, player.src, ...)
        end

        function obj.Callback(name, ...)
            
        end

        function obj.Sync.Callback(name, ...)

        end

        return obj
    end
})