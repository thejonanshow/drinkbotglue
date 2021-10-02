class ChangeImageDataToText < ActiveRecord::Migration[6.1]
  def change
    change_column :beverages, :image_data, :text
  end
end
