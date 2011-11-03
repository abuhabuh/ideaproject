require 'pusher' # for pusher events in broadcast function

module ApplicationHelper

  # Return a title
  def title
    base_title = "Just an Idea ... yay"
    return base_title
  end

  def broadcast(channel, event, &block)

    block_data = capture(&block)
    begin
      Pusher[channel].trigger!(event, block_data)
    rescue Pusher::Error => e
      puts "Pusher error: " + e.to_s
    end
    
  end

end
