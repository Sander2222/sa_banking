fx_version 'cerulean'
games { 'gta5' }
author 'Sander#2211'
description 'a keybind UI'

client_scripts {
    'client.lua',
    'config.lua'
}

server_scripts {
    'server.lua',
    'config.lua'
}

ui_page ('ui/ui.html')

files {
    'ui/ui.html',
    'ui/style.css',
    'ui/app.js',
    'ui/serverimg.png.png'
}

dependencies {
    'es_extended'
}