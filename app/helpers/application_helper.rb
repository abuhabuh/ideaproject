module ApplicationHelper

  # Return a title
  def title
    base_title = "Just an Idea ... yay"
    return base_title
  end

  def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block)}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

end
