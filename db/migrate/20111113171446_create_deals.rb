class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :title
      t.string :description
      t.string :vendor_name
      t.string :location

      t.string :purchase_link
      t.decimal :price, :precision => 9, :scale => 2
      t.decimal :original_price, :precision => 9, :scale => 2
      t.decimal :percent_off, :precision => 4, :scale => 2

      t.date :start_date
      t.date :end_date

      t.references :user      
            
      t.timestamps
    end
    
    add_index :deals, :user_id
  end
end

