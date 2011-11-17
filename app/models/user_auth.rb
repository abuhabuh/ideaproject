class UserAuth < ActiveRecord::Base
  belongs_to :users
  
  validates_presence_of :token, :provider, :provider_id, :user_id
end
