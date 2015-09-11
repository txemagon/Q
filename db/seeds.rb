# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'highline/import'



firstname = ask("Enter admin name: ") { |q| q.default = 'Txema'}
lastname  = ask("Surname: ") { |q| q.default = 'Gon'}
email     = ask("Email address from @salesianosdosa.com: ")
password  = ask("Enter RAC password: ") { |q| q.echo = false}
password_confirmation = ask("Confirm RAC password: ") { |q| q.echo = false}

raise "Passwords doesn't match." unless password == password_confirmation

User.create!(
	:first_name => firstname,
	:last_name  => lastname,
	:email    => email,
	:password => password,
	:password_confirmation => password_confirmation,
	:rac => true )
