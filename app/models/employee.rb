class Employee < ActiveRecord::Base
  validates :name, :presence =>true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  #validates :email, :presence =>true

  def self.create_with_omniauth(auth)
    Employee.create!(
                :name  => auth["info"]["name"],
                #:email => auth["email"],
                :uid      => auth["uid"],
                :provider => auth['provider']
    )
  end
end