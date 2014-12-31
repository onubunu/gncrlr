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

  validates :title, 
    :presence => true
  validates :prename, 
    :length => {:minimum => 2}
  validates :surname, 
    :length => {:minimum => 2}
  validates :phone, 
    :presence  => true,
    :on => :update,
    :uniqueness => true, 
    :allow_blank => true,
    :length => { :in => 6..12 }, 
    :format => { :with => /\A[0-9\+\-\/\(\)]+\Z/i, 
    :message => "is not valid" }
  validates :birthdate, 
    :presence  => true,
    :on => :update,
    :allow_blank => true 

  TITLE = ["Frau", "Herr"];
  
end

