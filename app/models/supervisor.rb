class Supervisor < ActiveRecord::Base
  belongs_to :supervisor, :class_name => "Employee"
  belongs_to :employee
end
