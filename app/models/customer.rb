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
z
  #muesteri
  validates :title, 
    :presence => true,
    :if => Proc.new { |customer| customer.password.present? } && Proc.new { |employee| employee.password.blank? }
  validates :prename, 
    :presence => true,
    :length => {:minimum => 2},
    :if => Proc.new { |customer| customer.password.present? } && Proc.new { |employee| employee.password.blank? }
  validates :surname,
    :presence => true,
    :length => {:minimum => 2},
    :if => Proc.new { |customer| customer.password.present? } && Proc.new { |employee| employee.password.blank? }
  validates :phone, 
    :presence  => true,
    :on => :update,
    :uniqueness => true, 
    :allow_blank => true,
    :length => { :in => 6..12 }, 
    :format => { :with => /\A[0-9\+\-\/\(\)]+\Z/i, 
    :message => "is not valid" },
    :if => Proc.new { |customer| customer.password.present? } && Proc.new { |employee| employee.password.blank? }
  validates :birthdate, 
    :presence  => true,
    :on => :update,
    :allow_blank => true,
    :if => Proc.new { |customer| customer.password.present? } && Proc.new { |employee| employee.password.blank? }
  
  #calisan
  validates :title, 
    :presence => true,
    :if => Proc.new { |employee| employee.password.present? } && Proc.new { |customer| customer.password.present? }
  validates :prename,
    :presence  => true,
    :length => {:minimum => 2},
    :if => Proc.new { |employee| employee.password.present? } && Proc.new { |customer| customer.password.present? }
  validates :surname,
    :presence  => true,
    :length => {:minimum => 2},
    :if => Proc.new { |employee| employee.password.present? } && Proc.new { |customer| customer.password.present? }
  validates :phone, 
    :uniqueness => true,
    :length => { :in => 6..12 }, 
    :format => { :with => /\A[0-9\+\-\/\(\)]+\Z/i, 
    :message => "is not valid" },
    :if => Proc.new { |employee| employee.password.present? } && Proc.new { |customer| customer.password.present? }
  validates :phonecode, 
    :presence  => true,
    :if => Proc.new { |employee| employee.password.present? } && Proc.new { |customer| customer.password.present? }
  validates :birthdate, 
    :presence  => true,
    :if => Proc.new { |employee| employee.password.present? } && Proc.new { |customer| customer.password.present? }

  TITLE = ["Frau", "Herr"];
  
end

