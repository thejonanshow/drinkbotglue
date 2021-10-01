class CreateMotors < ActiveRecord::Migration[6.1]
  def change
    create_table :motors do |t|
      t.belongs_to :beverage
      t.string :uuid, default: ""
      t.boolean :online, default: false

      t.timestamps
    end
  end
end
