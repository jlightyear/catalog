class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string "titulo", :limit => 50, :null => false
      t.string "ref_sec", :limit => 5, :null => false 

      t.timestamps
    end
  end
end
