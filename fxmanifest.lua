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
	'@oxmysql/lib/MySQL.lua',
	'server/functions.lua',
	'server/plantSpawns.lua',
	'serverRun.lua',
}

shared_scripts {
	'shared/**.lua',
}

lua54 'yes'

files {
	'client/**.lua',
	'server/**.lua',
	'locales/**.lua'
}
