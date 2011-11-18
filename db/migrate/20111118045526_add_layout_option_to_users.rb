class AddLayoutOptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_page_layout, :integer, :default => 0
  end
end
