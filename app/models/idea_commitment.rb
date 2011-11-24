class IdeaCommitment < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea
  
  attr_accessible :user_id, :idea_id
  


  def self.get_num_commits_outstanding(user_id)
    return IdeaCommitment.where(:user_id => user_id, :created_at => (Time.now - 1.month)..Time.now).count
  end

end
