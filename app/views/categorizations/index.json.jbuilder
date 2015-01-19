json.array!(@categorizations) do |categorization|
  json.extract! categorization, :id, :product_id, :category_id
  json.url categorization_url(categorization, format: :json)
end
