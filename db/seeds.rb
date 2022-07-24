# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
pack = Pack.create(name: '10M Mesos', status: 1, price: 3)
PackItem.create(pack_id: pack.id, item_type: 0, item_name: '10M Mesos', quantity: 10000000)
pack2 = Pack.create(name: '15k Nx Credit', status: 1, price: 5)
PackItem.create(pack_id: pack2.id, item_type: 4, item_name: '15k Nx Credit', quantity: 15000)
pack3 = Pack.create(name: 'Starter Pack', status: 1, price: 5)
PackItem.create(pack_id: pack3.id, item_type: 0, item_name: '3M Mesos', quantity: 3000000)
PackItem.create(pack_id: pack3.id, item_type: 4, item_name: '10k Nx Credit', quantity: 10000)
Notice.create(
	title: "New Game Launcher!",
	title_es: "Nuevo Game Launcher!",
	description: '<p><strong>Dear Maplers!</strong></p><p>&nbsp;</p><p>We are launching the new Game Launcher Beta, with which you will be able to access patches automatically!</p><p>You can also try the new Full HD beta resolution!</p><p>&nbsp;</p><p>Follow the next steps:</p><p>&nbsp;</p><ul><li>Go to the <a href=\"https://maplelatino.com/downloads\"><strong>download</strong></a> section and click download patch. You can also download the full game.</li><li>Turn off your antivirus! and unzip the folder you just downloaded, copy and replace the downloaded files in the Maplestory folder.</li><li>Double click on the Launcher.exe file and enjoy the game!</li></ul><p>&nbsp;</p><p><img src=\"https://maplelatino.com/images/launcher.png\" alt=\"launcher\"></p>',
	description_es: '<p><strong>Hola Maplers!</strong></p><p>&nbsp;</p><p>Estamos lanzando el nuevo Game Launcher Beta, con el cual podrás acceder a los parches de forma automática!</p><p>Además podrás probar la nueva resolución beta Full HD!</p><p>&nbsp;</p><p>Sigue los siguientes pasos:</p><p>&nbsp;</p><ul><li>Dirigete a la sección de <a href=\"https://maplelatino.com/downloads\"><strong>descargas</strong></a> y has click en descargar parche. También puedes descargar el juego completo.</li><li>Desactiva tu antivirus! y descomprime la carpeta que acabas de descargar, copia y reemplaza los archivos descargados en el folder de Maplestory.</li><li>Haz doble click en el archivo Launcher.exe y disfruta del juego!</li></ul><p>&nbsp;</p><p><img src=\"https://maplelatino.com/images/launcher.png\" alt=\"launcher\"></p>',
	status: "active",
	notice_type: 0
)
Notice.create(
	title: "Singapure - Ulu city Released!",
	title_es: "Sungapur - Ulu city está aquí!",
	description: "<p><strong>Dear Maplers!</strong></p><p>&nbsp;</p><p>Finally Ulu city is here!</p><p>Head to Boat Quay Twon, talk to Ralph and ask for Ulu's new quest!</p><p>&nbsp;</p><p>In order to access Ulu, you have to update the game, please follow the <a href=\"https://maplelatino.com/notices/1\">instructions below</a></p><p>&nbsp;</p><img src=\"https://maplelatino.com/images/ulu-quest.png\" alt=\"launcher\" />",
	description_es: "<p><strong>Hola Maplers!</strong></p><p>&nbsp;</p><p>Finalmente Ulu city está aquí!</p><p>Dirígete a Boat Quay Twon, habla con Ralph y pide la nueva misión de Ulu!</p><p>&nbsp;</p><p>Para poder acceder a Ulu, tienes que actualizar el juego, por favor sigue las siguientes <a href=\"https://maplelatino.com/notices/1\">intrucciones</a></p><p>&nbsp;</p><img src=\"https://maplelatino.com/images/ulu-quest.png\" alt=\"launcher\" />",
	status: "active",
	notice_type: 1
)