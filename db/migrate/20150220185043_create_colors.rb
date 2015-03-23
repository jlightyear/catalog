class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.string "color", :limit => 50, :null => false
      t.string "ref_col", :limit => 5, :null => false
    end
  end
end
