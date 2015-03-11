# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



team = [{:name =>'Zach'   , :email => "brownzach125@gmail.com" } ,   {:name =>'Elizabeth' , :email => "brownzach125@gmail.com"},
           {:name =>'Jon' ,  :email => "brownzach125@gmail.com"}  ,  {:name =>'Michael'   , :email => "brownzach125@gmail.com"},
           {:name =>'Garret'  , :email => "brownzach125@gmail.com"} ,{:name =>'Steven'    , :email => "brownzach125@gmail.com"}]

team.each do |mate|
  Employee.create!(mate)
end