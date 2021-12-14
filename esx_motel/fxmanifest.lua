fx_version 'cerulean'
game {'gta5' }

dependencies {
	"PolyZone"
}

shared_script '@es_extended/imports.lua'

client_scripts {
	'utils.lua',
	'client/markers.lua',
	'client/mysql.lua',
	'config.lua',
	'client/main.lua',
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
	'utils.lua',
	'config.lua',
	'server/main.lua',
	'server/sessions.lua'
}

