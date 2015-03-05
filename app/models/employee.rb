class Employee < ActiveRecord::Base
  validates :name, :presence =>true
  validates :salary, :presence =>true
end