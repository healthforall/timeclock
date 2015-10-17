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

team = [   {:name =>'Zach'    , :email => "brownzach125@gmail.com" } ,    {:name =>'Elizabeth' , :email => "bookworm920@gmail.com"},
           {:name =>'Jon'     , :email => "jtgoen@gmail.com"}        ,    {:name =>'Michael'   , :email => "md.stephens9@gmail.com"},
           {:name =>'Garret'  , :email => "swamp.fox076@gmail.com"}  ,    {:name =>'Steven'    , :email => "redynsnevets@gmail.com", :admin => true},
		       {:name =>'Employee', :email => "employee20156@gmail.com"}]

admin = { :name =>'admin' , :email => 'admit20156@gmail.com' , :admin => true}
admin = Employee.create!(admin)

admin = {:name =>'health4all', :email => "healthforall606@gmail.com", :admin=>true}
admin = Employee.create!(admin)
supervisor = { :name =>'Im a supervisor' , :email => 'suadhealth@gmail.com' }
Employee.create!(supervisor)

team.each do |mate|
  admin.employees.create!( mate  )
end





