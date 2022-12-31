local function exists(tab, value)
    for i,v in pairs(tab) do
        if v == value then
            return true
        end
    end
    return false
end

AddPlayerObject({
    name = 'Groups',
    object = function(steam, player, sql, obj, online, set, get)
        
        function obj.Exists(group)
            return GroupsConfiguration[group] ~= nil
        end

        function obj.Get()
            if not online() then
                local user = sql.GetPlayer(steam)
                local data = json.decode(user.data)
                if not user then
                    return false, "user_does_not_exist"
                end
                if not data then
                    return false, "user_has_no_data"
                end
                return data.groups, data
            else
                return get('groups')
            end
        end

        function obj.Has(group)
            local groups, err = obj.Get()
            if not obj.Exists(group) then
                return false, "invalid_group"
            end
            if not groups then
                return false, err
            end
            return exists(groups, group), err
        end

        function obj.Add(group)
            if not obj.Exists(group) then
                return false, "invalid_group"
            end

            local Has, Data = obj.Has(group)
            if not Has and Data ==  "user_does_not_exist" or Data == "user_has_no_data" then
                return false, Data
            end
            if Has then
                return false, "user_has_group"
            end

            if not online() then
                table.insert(Data.groups, group)
                sql.UpdatePlayerData(steam, Data)
            else
                table.insert(player.groups, group)
            end

            return true, "success"
        end

        function obj.Remove(group)
            if not obj.Exists(group) then
                return false, "invalid_group"
            end

            local Has, Data = obj.Has(group)
            if not Has then
                return false, "user_does_not_have_group"
            end
            local data = Data or player
            for i,v in pairs(data.groups) do
                if v == group then
                    table.remove(data.groups, i)
                end
            end
            
            if not online() then
                sql.UpdatePlayerData(steam, data)
            end

            return true, "success"
        end

        function obj.Permission(perm)
            local groups, err = obj.Get()
            if not groups then
                return groups, err
            end

            for i,v in pairs(groups) do
                local perms = GroupsConfiguration[v].perms or {}
                for i,v in pairs(perms) do
                    if v == perm then
                        return true
                    end
                end
            end
            return false
        end

        return obj
    end
})