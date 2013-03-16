class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, :presence => true
      t.text :description
      t.integer :owner_id, :presence => true

      t.timestamps
    end
  end
end
