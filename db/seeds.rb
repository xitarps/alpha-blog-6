# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username:'Xita', email:'xitarps@gmail.com', password:'123456', admin: true)
User.create(username:'zzz', email:'z@z.com', password:'111111', admin: false)
