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

        function obj.Has(group)
            if not obj.Exists(group) then
                return false, "invalid_group"
            end
            if not online() then
                local user = sql.GetPlayer(steam)
                local data = json.decode(user.data)
                if not user then
                    return false, "user_does_not_exist"
                end
                if not data then
                    return false, "user_has_no_data"
                end
                return exists(data.groups, group)
            else
                local has = exists(get('groups'), group)
                if not has then
                    return false, "user_no_group"
                else
                    return true, "user_has_group"
                end
            end
        end
        return obj
    end
})