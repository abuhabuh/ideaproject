class IdeaCommitment < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea
  
  attr_accessible :user_id, :idea_id
  


  def self.can_commit(user_id)
    outstanding_commitments = IdeaCommitment.where(:user_id => user_id, :created_at => (Time.now - 1.month)..Time.now).count
    
    puts "outstanding commitments: " + outstanding_commitments.to_s
    puts "per month: " + NUM_COMMITS_PER_MONTH.to_s
    
    return outstanding_commitments < NUM_COMMITS_PER_MONTH
  end

end
