class InAndOut < ActiveRecord::Base
  belongs_to :day
  scope      :find_dangling_in , lambda{
               InAndOut.where(:out_time => nil)
   }




  @@format = "%l:%M %p"
  def print_in
    (self.in_time  - 5.hours).strftime(@@format) unless !self.in_time
  end

  def print_out
    (self.out_time  - 5.hours).strftime(@@format) unless !self.out_time
  end
end
