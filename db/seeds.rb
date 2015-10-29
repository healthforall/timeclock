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
           {:name =>'Garret'  , :email => "swamp.fox076@gmail.com"}  ,    {:name =>'Steven'    , :email => "redynsnevets@gmail.com"},
		       {:name =>'Employee', :email => "employee20156@gmail.com"}  ,   {:name =>'Xiangpeng' , :email => 'wxp2002@gmail.com'} ,
           {:name =>'JingchengHuang' , :email => 'huang155439@gmail.com'},{:name =>'wutongzhang' , :email => 'wutongzhang@tamu.edu'} ,
            {:name => 'Tianshu', :email => "cts2003258@gmail.com"},       {:name => 'mona', :email => "ohnarya@gmail.com"}]

admin =[ { :name =>'admin' , :email => 'wxp2002@tamu.edu' , :admin => true},{ :name =>'tianshu' , :email => 'chutianshu@tamu.edu' , :admin => true}]
adminList = []
admin.each do |supervisor|
  adminList << Employee.create!(supervisor)
end

#supervisor = { :name =>'Im a supervisor' , :email => 'suadhealth@gmail.com' }
#Employee.create!(supervisor)
adminList.each do |administrator|
  team.each do |mate|
    administrator.employees.create!( mate  )
  end
end




