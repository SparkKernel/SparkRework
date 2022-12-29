fx_version 'cerulean'
game 'gta5'

author 'Fr3ckzDK <github.com/dkfrede>'
description 'Rework of the Sparkling framework'
version '1.0'

shared_scripts {
    'shared/debug.lua'
}

server_scripts {
    'config/player.lua',
    'config/database.lua',

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
}

client_scripts {
    'client/callback.lua',
    'client/client.lua',
    'client/commands.lua',
    'client/functions.lua',
    'client/spawned.lua'
}

--shared_script ''