class Employee < ActiveRecord::Base

  after_initialize :init


  validates :name, :presence =>true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :email, :presence =>true
  validates :email, :uniqueness => true

  #The four lines below setup the relationship between employees and supervisors
  has_many   :ownerships, :class_name => "Supervisor" , :foreign_key => "supervisor_id"
  has_many   :employees,  :through => :ownerships, :source => :employee
  has_one    :owner     , :class_name => "Supervisor" , :foreign_key => "employee_id"
  has_one    :supervisor, :through => :owner, :source => :supervisor
  #-----------------------------------------------------------

  has_many   :timesheets


  def clockin?
    #debugger
    self.timesheets.current[0].clockin?
  end

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

  def clock_in(clockin)
    if clockin == "true"
      self.timesheets.current[0].days.current[0].in_and_outs.create!(:in_time => DateTime.now())
    elsif clockin == "false"
      inandout = self.timesheets.current[0].days.current[0].in_and_outs.find_dangling_in[0]
      inandout.out_time = DateTime.now() if inandout
      inandout.save! if inandout
    end
  end

  def init
    self.admin ||= false
  end

end