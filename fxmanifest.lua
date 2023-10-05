name "mustache-drugs"
author "mustache_dom"
description "drugs by mustache dom"
fx_version "cerulean"
game "gta5"

client_scripts {
	'client/**.lua',
	'@PolyZone/client.lua',
   	 '@PolyZone/CircleZone.lua',
}

server_scripts {
    'server/**.lua',
	'@oxmysql/lib/MySQL.lua',
	
}

shared_scripts {
    'config.lua',
	
	
}


lua54 'yes'

dependency '/assetpacks'
