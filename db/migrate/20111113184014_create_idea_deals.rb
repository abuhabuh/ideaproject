class CreateIdeaDeals < ActiveRecord::Migration
  def self.up
    create_table :idea_deals do |t|
      t.references :idea
      t.references :deal

      t.timestamps
    end
    add_index :idea_deals, :idea_id
    add_index :idea_deals, :deal_id

		change_table :idea_deals do |t|
      t.foreign_key :ideas
      t.foreign_key :deals
    end

  end

  def self.down
    change_table :idea_deals do |t|
      t.remove_foreign_key :deals
      t.remove_foreign_key :ideas
    end

  	drop_table :idea_deals
  end
end
