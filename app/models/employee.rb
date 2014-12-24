class Employee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable, :confirmable, :timeoutable, :timeout_in => 15.minutes

  validates :prename, length: {:minimum => 2}
  validates :surname, length: {:minimum => 2}

end
