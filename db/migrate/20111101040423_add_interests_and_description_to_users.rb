class AddInterestsAndDescriptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :description, :string
    add_column :users, :interests, :string
  end
end
