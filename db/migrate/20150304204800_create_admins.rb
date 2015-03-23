class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string   "username",        limit: 25
      t.string   "password_digest"
      t.string   "email",           limit: 100, default: "", null: false
      t.boolean  "active",          default: true

      t.timestamps
    end
  end
end
