AddPlayerObject({
    name = 'Cash',
    object = function(steam, player, sql, obj, online, set, get)
        function obj.Get()
            if not online() then
                return false, "user_not_online"
            end
            return get('cash')
        end

        function obj.Set(cash)
            if not online() then
                return false, "user_not_online"
            end
            set('cash', cash)
        end

        function obj.Add(cash)
            if not online() then
                return false, "user_not_online"
            end
            set('cash', get('cash')+cash)
        end

        function obj.Remove(cash)
            if not online() then
                return false, "user_not_online"
            end
            local currentCash = get('cash')
            if currentCash-cash > 0 then
                set('cash', currentCash-cash)
                return true, "success"
            else
                return false, "under_zero"
            end
        end

        function obj.Payment(cash)
            if not online() then
                return false, "user_not_online"
            end
            local currentCash = get('cash')
            if currentCash >= cash then
                set('cash', currentCash-cash)
                return true
            else
                return false
            end
        end

        return obj
    end
})