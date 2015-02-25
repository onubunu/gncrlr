class Product < ActiveRecord::Base

  #attr_accessible :category_ids, :description, :name
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

	def self.latest
		Product.order(:updated_at).last
	end
	
  private

	def ensure_not_referenced_by_any_line_item
	  if line_items.empty?
	    return true
	  else
	    errors.add(:base, 'Line Items present')
	    return false
	  end
	end

end
