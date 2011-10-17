class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.date :date
      t.string :location

      t.timestamps
    end
  end
end
