class CreateMotors < ActiveRecord::Migration[6.1]
  def change
    create_table :motors do |t|
      t.belongs_to :beverage, index: { unique: true }, foreign_key: true
      t.string :uuid, default: ""
      t.boolean :online, default: false

      t.timestamps
    end
  end
end
