class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.integer :project_id
      t.integer :assigned_to
      t.boolean :state

      t.timestamps
    end
  end
end
