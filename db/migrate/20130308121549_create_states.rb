class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.integer :project_id
      t.string :title
      t.boolean :open, :default => true

      t.timestamps
    end
  end
end
