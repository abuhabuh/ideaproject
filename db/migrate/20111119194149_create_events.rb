class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, :null => false
      t.string :description
      t.string :location
      t.date :start_date
      t.date :end_date
      t.integer :visibility
      t.integer :status
      t.integer :num_users_joined, :null => false, :default => 0

      t.timestamps
    end
  end
end
