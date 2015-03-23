class AddReferenciaProducts < ActiveRecord::Migration
  def change
  	add_column :products, :ref_pro, :string, :limit => 20, :null => false
  end
end
