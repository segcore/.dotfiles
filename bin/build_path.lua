#!/usr/bin/env lua

local path = os.getenv('PATH')
path = string.gsub(path, '[^:]+:?', function(item)
    if string.find(item, '/mnt/./') and not string.find(item, 'Neovim') then
        return ""
    end
end)
print(path)
