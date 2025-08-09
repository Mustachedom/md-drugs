name "mustache-drugs"
author "mustache_dom"
description "drugs by mustache dom"
fx_version "cerulean"
game "gta5"
version  '3.9.0'
client_scripts {
	'client/functions.lua',
	'client/animationsandfunctions.lua',
	'client/plantSpawns.lua',
	'clientRun.lua',
}

server_scripts {
	'server/functions.lua',
	'server/plantSpawns.lua',
	'serverRun.lua',
	'@oxmysql/lib/MySQL.lua',
}

shared_scripts {
	'shared/**.lua',
}

lua54 'yes'

files {
    'stream/mushroom.ytyp',
    'stream/mushroom.ydr',
	'client/**.lua',
	'server/**.lua',
	'locales/**.lua'
}

data_file 'DLC_ITYP_REQUEST' 'stream/mushroom.ytyp'
