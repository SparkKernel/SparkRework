fx_version 'cerulean'
game 'gta5'

author 'Fr3ckzDK <github.com/dkfrede>'
description 'Rework of the Sparkling framework'
version '1.0'

ui_page 'interface/index.html'
files {
    'interface/index.html',
    'interface/index.css',
    'interface/index.js',
    'interface/clipboard/handler.js',
}

shared_scripts {
    'shared/debug.lua'
}

server_scripts {
    'config/player.lua',
    'config/database.lua',
    'config/groups.lua',

    'server/*',

    'server/database/db.js',
    'server/database/db.lua',
    'server/database/tables.lua',
    'server/database/functions.lua',

    'server/users/events.lua',
    'server/users/data.lua',
    'server/users/identifiers.lua',
    'server/users/users.lua',
    'server/users/spawn.lua',
    'server/users/drop.lua',
    'server/users/object.lua',

    'server/users/objects/client.lua',
    'server/users/objects/cash.lua',
    'server/users/objects/position.lua',
    'server/users/objects/groups.lua',
    'server/users/objects/nui.lua',
}

client_scripts {
    'client/callback.lua',
    'client/client.lua',
    'client/commands.lua',
    'client/functions.lua',
    'client/spawned.lua',
    'client/nui.lua'
}

--shared_script ''