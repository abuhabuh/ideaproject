class AddFeaturedColumnToIdeas < ActiveRecord::Migration
  def self.up
    add_column :ideas, :featured, :integer, :default => 0
  end

  def self.down
    remove_column :ideas, :featured
  end
end
