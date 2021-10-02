class Motor < ApplicationRecord
  belongs_to :beverage, optional: true
end
