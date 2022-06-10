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