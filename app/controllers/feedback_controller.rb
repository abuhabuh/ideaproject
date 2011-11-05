class FeedbackController < ApplicationController

  def index
    # Render only the last 
    @feedback_messages = AdminMessage.order("id DESC").limit(30)
  end
  
end
