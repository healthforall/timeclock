class InAndOut < ActiveRecord::Base
  belongs_to :day
  scope      :find_dangling_in , lambda{
               InAndOut.where(:out => nil)
                               }
end
