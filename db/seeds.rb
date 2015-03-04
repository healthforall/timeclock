# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



team = [{:name =>'Zach' , :salary => '0'} ,  {:name =>'Elizabeth' , :salary => '0'},
           {:name =>'Jon' , :salary => '0'}  ,  {:name =>'Michael' , :salary => '0'},
           {:name =>'Garret' , :salary => '0'} ,{:name =>'Steven' , :salary => '0'}]

team.each do |mate|
  Employee.create!(mate)
end