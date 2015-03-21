# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Clear the database first
Employee.all().each do |emp|
  emp.destroy!()
end

Payperiod.all().each do |pay|
  pay.destroy!()
end

payperiod = {:start_date => DateTime.parse("2015-3-16") , :end_date =>DateTime.parse("2015-3-31")}
payperiod = Payperiod.create!(payperiod)

team = [   {:name =>'Zach'   , :email => "brownzach125@gmail.com" } ,    {:name =>'Elizabeth' , :email => "bookworm920@gmail.com"},
           {:name =>'Jon'    , :email => "jon@gmail.com"}           ,    {:name =>'Michael'   , :email => "md.stephens9@gmail.com"},
           {:name =>'Garret' , :email => "swamp.fox076@gmail.com"}  ,    {:name =>'Steven'    , :email => "steven@gmail.com"},]

admin = { :name =>'admin' , :email => 'admit20156@gmail.com' , :admin => true}
admin = Employee.create!(admin)

supervisor = { :name =>'Im a supervisor' , :email => 'suadhealth@gmail.com' }
Employee.create!(supervisor)

team.each do |mate|
  admin.employees.create!( mate  )
end


shifts = [ { in: DateTime.parse( 'March 20th 2015 08:00:00 AM') , out: DateTime.parse('March 20th 2015 10:00:00 AM')} , { in: DateTime.parse( 'March 20th 2015 12:00:00 PM') , out: DateTime.parse('March 20th 2015 2:00:00 PM')} ,
             in: DateTime.parse( 'March 21th 2015 08:00:00 AM') , out: DateTime.parse('March 21th 2015 10:00:00 AM') ]

zach = Employee.find_by_name("Zach")
time = zach.timesheets.create!()
shifts.each do |shift|
  time.days.find_by_date(shift[:in])[0].in_and_outs.create!(shift)
end




