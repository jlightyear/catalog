class AddImageTitularDescripcionSection < ActiveRecord::Migration
  def change
  	add_column :sections, :titular, :text, :limit => 400, :null => false
    add_column :sections, :image_file_name, :string
    add_column :sections, :image_content_type, :string
    add_column :sections, :image_file_size, :integer
    add_column :sections, :image_updated_at, :datetime
  end
end
