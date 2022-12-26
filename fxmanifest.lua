fx_version 'adamant'
game 'gta5'

author 'Fr3ckzDK <github.com/dkfrede>'
description 'Rework of the Sparkling framework'
version '1.0'

server_scripts {
  "server/*.lua",
  "server/groups/*.lua",
  "server/users/*.lua",
}

client_scripts {
  "client/*.lua",
}

shared_scripts {
  "shared/*.lua",
  "config/*.lua",
}