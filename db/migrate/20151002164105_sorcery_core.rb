class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email,            :null => false
      t.string :crypted_password
      t.string :salt
      t.string :first_name,       :null => false, :default => ''
      t.string :last_name,        :null => false, :default => ''
      t.string :username,         :null => false, :default => ''
      t.string :role,             :null => false, :default => 'default'

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
  end
end