class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :presence => true
      t.string :email, :presence => true, :uniqueness => true, :format => { :with => /^[a-zA-z0-9]+[\w\.]*\w+@\w+\.[a-zA-Z]{2,3}$/i }
      t.string :password_digest, :presence => true

      t.timestamps
    end
  end
end
