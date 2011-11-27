class CreateDeals < ActiveRecord::Migration
  def self.up
    create_table :deals do |t|
      # TODO: not sure which attributes should be required

      t.string :title, :null => false
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

      t.string :deal_photo_file_name
      t.string :deal_photo_content_type
      t.integer :deal_photo_file_size
      t.datetime :deal_photo_updated_at

      t.timestamps
    end
    
    add_index :deals, :user_id

    change_table :deals do |t|
      t.foreign_key :users
    end
  end


  def self.down
    change_table :deals do |t|
      t.remove_foreign_key :users
    end

    drop_table :deals
  end
end

