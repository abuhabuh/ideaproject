class AddUserTableColumns < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :user_name
      t.string :location
      t.date   :dob
    end  
  end

  def down
    change_table :users do |t|
      t.remove :first_name, :last_name, :user_name, :location, :dob
    end
  end

end
