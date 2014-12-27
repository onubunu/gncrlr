class Employee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable, :confirmable, :timeoutable, :timeout_in => 15.minutes

  before_save :titleize
  before_create :titleize

  def titleize
    self.prename = self.prename.titleize
    self.surname = self.surname.titleize
  end
  
  validates :prename, length: {:minimum => 2}
  validates :surname, length: {:minimum => 2}

end
