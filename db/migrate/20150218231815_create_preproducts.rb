class CreatePreproducts < ActiveRecord::Migration
  def change
    create_table :preproducts do |t|
      t.string "titulo", :limit => 75, :null => false
      t.text "descripcion", :limit => 400
      t.float "precio", :default => 0
      t.string "ref_pre", :limit => 10, :null => false

      t.integer "section_id", :null => false

      t.timestamps
    end
  end
end
