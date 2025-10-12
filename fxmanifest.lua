name "mustache-drugs"
author "mustache_dom"
description "drugs by mustache dom"
fx_version "cerulean"
game "gta5"
version  '4.0.6'
client_scripts {
	'client/functions.lua',
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
 '@ox_lib/init.lua', 
	'shared/**.lua',
}

lua54 'yes'

files {
	'client/**.lua',
	'server/**.lua',
	'locales/**.lua'
}
