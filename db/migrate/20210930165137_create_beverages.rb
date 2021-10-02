class CreateBeverages < ActiveRecord::Migration[6.1]
  def change
    create_table :beverages do |t|
      t.string :name, default: "yum yum yummy yum"
      t.string :identifier, default: ""
      t.integer :amount, default: 10
      t.string :image_url, default: ""
      t.binary :image_data

      t.timestamps
    end
  end
end
