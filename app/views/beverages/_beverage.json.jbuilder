json.extract! beverage, :id, :name, :identifier, :amount, :image_url, :image_data, :created_at, :updated_at
json.url beverage_url(beverage, format: :json)
