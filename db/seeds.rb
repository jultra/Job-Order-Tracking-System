# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#user = User.create(:username => "be", :position => "Student", :fname =>"Bea", :mname => "Santos", :lname => "Santiago", :email =>"bdSantiago@up.edu.ph", :password =>"art", :password_confirmation => "art", :active => true, :approved => true, :confirmed => true);
#params.require(:user).permit(:username, :position, :fname, :mname, :lname, :email, :password, :password_confirmation)
User.create( username: 'teles', fname: 'Telesforo', mname:	'Santos', lname: 'Sales', email: 'ts@up.edu.ph', Division_Department:	'Supervising Administrative Office', active: true, confirmed: true, approved: true)
User.create( username: 'jcarlos', fname: 'Juan', mname:	'Carlos', lname: 'cdmo', email: 'jc@up.edu.ph', Division_Department:	'CDMO', active: true, confirmed: true, approved: true)
User.create( username: 'juana', fname: 'Juana', mname:	'Math', lname: 'Alta', email: 'jm@up.edu.ph', Division_Department:	'CDMO', active: true, confirmed: true, approved: true)
User.find(1).add_role :SAO_Admin
User.find(2).add_role :CDMO_Admin
User.find(3).add_role :CDMO_Staff