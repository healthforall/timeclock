# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)




team = [   {:name =>'Zach'   ,  :email => "brownzach125@gmail.com" } ,    {:name =>'Elizabeth' , :email => "eliz@gmail.com"},
           {:name =>'Jon' ,     :email => "jon@gmail.com"}  ,   {:name =>'Michael'   , :email => "michale@gmail.com"},
           {:name =>'Garret'  , :email => "garret@gmail.com"} ,    {:name =>'Steven'    , :email => "steven@gmail.com"}]

team.each do |mate|
  Employee.create!(mate)
end

admin = { :name =>'admin' , }