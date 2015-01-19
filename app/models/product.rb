class Product < ActiveRecord::Base

  #attr_accessible :category_ids, :description, :name
  has_many :categorizations
  has_many :categories, through: :categorizations
  
end
