AddPlayerObject({
    name = 'Position',
    object = function(steam, player, sql, obj, online, set, get)
        function obj.Get()
            if not online() then
                return false, "user_not_online"
            end

            local position = GetEntityCoords(GetPlayerPed(player.src))
            return position.x, position.y, position.z
        end

        function obj.Set(x,y,z)
            if not online() then
                return false, "user_not_online"
            end

            SetEntityCoords(
                GetPlayerPed(player.src),
                x,
                y,
                z,
                false,
                false,
                false
            )
            return true
        end

        return obj
    end
})