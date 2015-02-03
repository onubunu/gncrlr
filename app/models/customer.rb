class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  before_save :titleize
	before_create :titleize
	
	def titleize
	  self.prename = self.prename.titleize
	  self.surname = self.surname.titleize
	end

#customer#########################
# title-pflicht für customer bei customer edit aber nicht bei create
  validates_presence_of   :title, :on => :update, :if => Proc.new { |customer| customer.created_by_employee == false } 
# prename-pflicht für customer bei customer edit aber nicht bei create
  validates_presence_of   :prename, :on => :update, :if => Proc.new { |customer| customer.created_by_employee == false }  
# surname-pflicht für customer bei customer edit aber nicht bei create
  validates_presence_of   :surname, :on => :update, :if => Proc.new { |customer| customer.created_by_employee == false }  
# birthdate-pflicht für customer bei customer edit aber nicht bei create
  validates_presence_of   :birthdate, :on => :update, :if => Proc.new { |customer| customer.created_by_employee == false }  

#employee#########################
# title-pflicht für employee bei customer edit und create
  validates_presence_of   :title, :if => Proc.new { |customer| customer.created_by_employee == true } 
# prename-pflicht für employee bei customer edit und create
  validates_presence_of   :prename, :if => Proc.new { |customer| customer.created_by_employee == true } 
# surname-pflicht für employee bei customer edit und create
  validates_presence_of   :surname, :if => Proc.new { |customer| customer.created_by_employee == true } 
# birthdate-pflicht für employee bei customer edit und create
  validates_presence_of   :birthdate, :if => Proc.new { |customer| customer.created_by_employee == true } 
# phone-pflicht für employee bei customer edit und create
  validates_presence_of   :phone, :if => Proc.new { |customer| customer.created_by_employee == true } 
# phonecode-pflicht für employee bei customer edit und create
  validates_presence_of   :phonecode, :if => Proc.new { |customer| customer.created_by_employee == true } 


  validates_presence_of   :email
  validates_uniqueness_of :email, allow_blank: true, if: :email_changed?
  validates_format_of     :email, with: email_regexp, allow_blank: true, if: :email_changed?

  validates_presence_of     :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, within: password_length, allow_blank: true

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  # #muesteri
  # validates :title, 
  #   :presence => true,
  #   :if => Proc.new { |customer| customer.password.present? } && Proc.new { |employee| employee.password.blank? }
  # validates :prename, 
  #   :presence => true,
  #   :length => {:minimum => 2},
  #   :if => Proc.new { |customer| customer.password.present? } && Proc.new { |employee| employee.password.blank? }
  # validates :surname,
  #   :presence => true,
  #   :length => {:minimum => 2},
  #   :if => Proc.new { |customer| customer.password.present? } && Proc.new { |employee| employee.password.blank? }
  # validates :phone, 
  #   :presence  => true,
  #   :on => :update,
  #   :uniqueness => true, 
  #   :allow_blank => true,
  #   :length => { :in => 6..12 }, 
  #   :format => { :with => /\A[0-9\+\-\/\(\)]+\Z/i, 
  #   :message => "is not valid" },
  #   :if => Proc.new { |customer| customer.password.present? } && Proc.new { |employee| employee.password.blank? }
  # validates :birthdate, 
  #   :presence  => true,
  #   :on => :update,
  #   :allow_blank => true,
  #   :if => Proc.new { |customer| customer.password.present? } && Proc.new { |employee| employee.password.blank? }
  
  # #calisan
  # validates :title, 
  #   :presence => true,
  #   :if => Proc.new { |employee| employee.password.present? } && Proc.new { |customer| customer.password.present? }
  # validates :prename,
  #   :presence  => true,
  #   :length => {:minimum => 2},
  #   :if => Proc.new { |employee| employee.password.present? } && Proc.new { |customer| customer.password.present? }
  # validates :surname,
  #   :presence  => true,
  #   :length => {:minimum => 2},
  #   :if => Proc.new { |employee| employee.password.present? } && Proc.new { |customer| customer.password.present? }
  # validates :phone, 
  #   :uniqueness => true,
  #   :length => { :in => 6..12 }, 
  #   :format => { :with => /\A[0-9\+\-\/\(\)]+\Z/i, 
  #   :message => "is not valid" },
  #   :if => Proc.new { |employee| employee.password.present? } && Proc.new { |customer| customer.password.present? }
  # validates :phonecode, 
  #   :presence  => true,
  #   :if => Proc.new { |employee| employee.password.present? } && Proc.new { |customer| customer.password.present? }
  # validates :birthdate, 
  #   :presence  => true,
  #   :if => Proc.new { |employee| employee.password.present? } && Proc.new { |customer| customer.password.present? }



# #aus controller
#   def new
#     Customer.validates :prename, :length => {:minimum => 2}
#        Customer.validates :title, :presence => true
# #Customer.validates :prename, :length => {:minimum => 2}

#     Customer.validates :phone, presence: true, :allow_blank => true
#     Customer.validates :phonecode, presence: true, :allow_blank => true
#     Customer.validates :birthdate, presence: true, :allow_blank => true
#     super
#   end

#   # PUT /resource
#   def update
#     super
#             Customer.validates :prename, :length => {:minimum => 2}
#        Customer.validates :title, :presence => true
# #Customer.validates :prename, :length => {:minimum => 2}

#     Customer.validates :phone, presence: true, :allow_blank => true
#     Customer.validates :phonecode, presence: true, :allow_blank => true
#     Customer.validates :birthdate, presence: true, :allow_blank => true
#   end



  TITLE = ["Frau", "Herr"];
  
end

