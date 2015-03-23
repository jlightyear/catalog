class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer "color_id"
      t.integer "preproduct_id"

      t.string "titulo", :limit => 75
      t.text "descripcion", :limit => 400
      t.float "precio", :default => 0

      t.string "image_file_name"
      t.string "image_content_type"
      t.integer "image_file_size"
      t.datetime "image_updated_at"

      t.timestamps
    end
  end
end
