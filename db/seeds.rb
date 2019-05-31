# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

#To correctly seed the database run this command: rake db:drop db:create db:migrate db:seed

puts "Seeding...."
office = Office.create(name: 'System Administrator', acronym: 'SA')

puts "Created office"

puts "Office Name: #{office.name}\n"

user = User.create(username: 'sysad', position: 'Administrator', email: 'sysad@up.edu.ph', office_id: office.id,
		fname: 'System', mname: '', lname: 'Administrator', password: 'password', password_confirmation: 'password')

user.active = true
user.approved = true 
user.confirmed = true

puts "Created user"
puts "Username: #{user.username}"
puts "Email: #{user.email}"
puts "Password: password \n"

office.user_id = user.id
user.add_role :Administrator

puts "Added Role"
puts "Role: Administrator"

user.save!
office.save!

@off = Office.where(:name => 'System Administrator')
puts "Office ID: #{@off.first.id}\n"
user.office_id = @off.first.id
user.save!




