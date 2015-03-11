class Employee < ActiveRecord::Base
  validates :name, :presence =>true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  #validates :email, :presence =>true

  def self.create_with_omniauth(auth)
    Employee.create!(
                :name     => auth["info"]["name"],
                :uid      => auth["uid"],
                :email    => auth["info"]["email"]
    )
  end

 # def self.find_by_uid(uid)
  #  @employee = Employee.find_by_uid(uid)
  #end
end