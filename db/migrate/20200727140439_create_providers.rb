class CreateProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :providers do |t|
      t.integer :user_id, null:false
      t.string :name, null: false
      t.string :uid, null: false
      t.text :auth_hash, null: false
      t.string :email, default: ""
      t.text :access_token, null: false
      t.timestamps
    end
    add_index :providers, :uid, unique: true
    add_index :providers, :access_token, unique: true
    add_index :providers, :email
    add_index :providers, [:user_id, :name]
  end
end
