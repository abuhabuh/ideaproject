class AddWantItAndProdColumnToUserIdea < ActiveRecord::Migration
  def change
    add_column :user_ideas, :want_it_count, :integer, :default => 0
    add_column :user_ideas, :prod_count, :integer, :default => 0
  end
end
