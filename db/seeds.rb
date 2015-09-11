# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'highline/import'

password = ask("Enter RAC password: ") { |q| q.echo = false}
password_confirmation = ask("Confirm RAC password: ") { |q| q.echo = false}

Rac.create( 
	:email => 'txema.gonz@gmail.com', 
	:password => password, 
	:password_confirmation => password_confirmation )
