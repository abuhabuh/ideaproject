# CONSTANTS FOR IDEA PROJECT


# Faye messaging js file URIs
FAYE_JS_LOC = 'http://localhost:9292/faye.js' # default to development
FAYE_URI = 'http://localhost:9292/faye' # default to development
if Rails.env.test?
# TODO: change to actual test URL
  FAYE_JS_LOC = 'http://localhost:9292/faye.js'
  FAYE_URI = 'http://localhost:9292/faye'
elsif Rails.env.production?
  FAYE_JS_LOC = 'http://young-galaxy-9203.heroku.com:9292/faye.js'
  FAYE_URI = 'http://young-galaxy-9203.heroku.com:9292/faye'
end


# Stream View Constants
STREAM_VIEW_PUBLIC = "public"
STREAM_VIEW_FRIENDS = "friends"


# AJAX ID TAGS
#   User list view page
ID_TAG_USER_LIST_USER_ROW = "user_list_row_id_" #append user id
#   Idea view page
ID_TAG_IDEA_CHAT = "idea_view_chat_id_" #append idea id
#   Main authenticated home page
ID_TAG_AUTH_HOME_STREAM_IDEA_ACTION = "auth_home_stream_idea_action_id_" #append idea id
ID_TAG_AUTH_HOME_STREAM_NUM_USERS = "auth_home_stream_num_users_" #append idea id
ID_TAG_AUTH_HOME_USER_IDEAS = "auth_home_user_ideas"


# MESSAGES
USER_ACTION_FRIENDSHIP_ADDED = "Friend has been added."
USER_ACTION_FRIENDSHIP_ADD_ERROR = "Error adding friend."
USER_ACTION_FRIENDSHIP_REMOVED = "Friend removed."
