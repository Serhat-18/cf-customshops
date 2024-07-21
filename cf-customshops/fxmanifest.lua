fx_version 'cerulean'
game 'gta5'

author 'Serhatsal'
description 'Custom market system for FiveM'
version '1.0'

client_scripts {
    'client/*.lua'
}
server_scripts {
    'server/*.lua'
}
shared_scripts {
    'shared/*.lua',
    'locales/*.lua',
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua'
}
