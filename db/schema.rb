# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_30_165537) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beverages", force: :cascade do |t|
    t.bigint "motor_id"
    t.string "name", default: "yum yum yummy yum"
    t.string "identifier", default: ""
    t.integer "amount", default: 10
    t.string "image_url", default: ""
    t.binary "image_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["motor_id"], name: "index_beverages_on_motor_id"
  end

  create_table "motors", force: :cascade do |t|
    t.string "uuid", default: ""
    t.boolean "online", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end