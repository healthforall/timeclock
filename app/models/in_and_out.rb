class InAndOut < ActiveRecord::Base
  belongs_to :day
  scope      :find_dangling_in , lambda{
               InAndOut.where(:out => nil)
   }

  @@format = "%l:%M %p"
  def print_in
    (self.in  - 5.hours).strftime(@@format) unless !self.in
  end

  def print_out
    (self.out  - 5.hours).strftime(@@format) unless !self.out
  end
end
