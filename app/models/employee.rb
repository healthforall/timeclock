class Employee < ActiveRecord::Base
  validates :name, :presence =>true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :email, :presence =>true
  validates :email, :uniqueness => true

  def self.create_on_first_login(auth)
    @employee = Employee.find_by_email(auth['info']['email'])
    if (@employee)
      @employee.uid= auth['uid']
      @employee.save!
      return @employee
    else
      return nil
    end


  end

end