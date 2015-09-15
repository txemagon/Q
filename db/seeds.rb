# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'highline/import'



firstname = ask("Enter #{ENV['ADMIN_ROLE']} given name: ") { |q| q.default = ENV['ADMIN_FIRST_NAME']}
lastname  = ask("Enter #{ENV['ADMIN_ROLE']} family name: ") { |q| q.default = ENV['ADMIN_LAST_NAME']}
email     = ask("Email address from salesianosdosa.com (type full address): ") do |q| 
	q.default = ENV['ADMIN_EMAIL']
end
password  = ask("Enter #{ENV['ADMIN_ROLE']} password: ") do 
	|q| q.echo = false
	q.default = ENV['ADMIN_PASSWORD']
end
password_confirmation = ask("Confirm #{ENV['ADMIN_ROLE']} password: ") do |q| 
	q.echo = false
	q.default = ENV['ADMIN_PASSWORD']
end

raise "Passwords doesn't match." unless password == password_confirmation

the_admin = User.new(
	:first_name => firstname,
	:last_name  => lastname,
	:email    => email,
	:password => password,
	:password_confirmation => password_confirmation,
	:admin => true )

the_admin.skip_confirmation!
the_admin.save!
