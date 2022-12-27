fx_version 'cerulean'
game 'gta5'

author 'Fr3ckzDK <github.com/dkfrede>'
description 'Rework of the Sparkling framework'
version '1.0'

server_scripts {
    'config/player.lua',
    'config/database.lua',

    'server/*',

    'server/database/db.js',
    'server/database/db.lua',
    'server/database/tables.lua',
    'server/database/functions.lua',

    'server/users/events.lua',
    'server/users/*',
}

client_scripts {
    'client/*'
}

--shared_script ''