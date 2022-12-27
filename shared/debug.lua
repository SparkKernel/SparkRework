local function create(color)
    return function(text, name)
        name = name or 'Sparkling'
        print("\27["..color.."["..name.."] | "..text.."\27[0m")
    end
end

Error, Debug, Warn, Success = create('31;1m'), create('34;1m'), create('33m'), create('0;92m')