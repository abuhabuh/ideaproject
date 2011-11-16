class CreateIdeaDeals < ActiveRecord::Migration
  def change
    create_table :idea_deals do |t|
      t.references :idea
      t.references :deal

      t.timestamps
    end
    add_index :idea_deals, :idea_id
    add_index :idea_deals, :deal_id
  end
end
