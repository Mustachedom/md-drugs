name "mustache-drugs"
author "mustache_dom"
description "drugs by mustache dom"
fx_version "cerulean"
game "gta5"

client_scripts {
	'client/wholesale.lua',
	'client/cocaine.lua',
	'client/heroin.lua',
	'client/lsd.lua',
	'client/target.lua',
	'client/crack.lua',
	'client/shrooms.lua',
	'client/pharma.lua',
	'client/xtc.lua',
	'@PolyZone/client.lua',
   	 '@PolyZone/CircleZone.lua',
}

server_scripts {
    'server/cocaine.lua',
	'server/heroin.lua',
	'server/lsd.lua',
	'server/crack.lua',
	'server/shrooms.lua',
	'server/pharma.lua',
	'server/xtc.lua',
	'server/wholesale.lua',
}

shared_scripts {
    'config.lua',
}



lua54 'yes'

dependency '/assetpacks'
