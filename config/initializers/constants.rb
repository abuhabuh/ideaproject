# CONSTANTS FOR IDEA PROJECT


# Pusher chat config
Pusher.app_id = '10463'
Pusher.key = '8c4eff4efff8afc004d2'
Pusher.secret = '8d035ff5acc21edf0fcb'
PUSHER_CHAT_MSG_EVENT = 'chat_msg_event'
PUSHER_CHANNEL_PREFIX_IDEA = 'presence-idea_dev_' # append idea id for unique channel per idea - default to dev
if Rails.env.test?
  PUSHER_CHANNEL_PREFIX_IDEA = 'presence-idea_test_'
elsif Rails.env.production?
  PUSHER_CHANNEL_PREFIX_IDEA = 'presence-idea_prod_'
end
PUSHER_CHANNEL_FEEDBACK_CHAT = "presence-feedback_chat"


# Stream View Constants
STREAM_VIEW_PUBLIC = "public"
STREAM_VIEW_FRIENDS = "friends"
STREAM_VIEW_SEARCH = "search"


# AJAX ID tags
#   User list view page
ID_TAG_USER_LIST_USER_ROW = "user_list_row_id_" #append user id
#   Idea view page
ID_TAG_IDEA_CHAT = "idea_view_chat_id_" #append idea id
#   Main authenticated home page
ID_TAG_AUTH_HOME_STREAM_IDEA_ACTION = "auth_home_stream_idea_action_id_" #append idea id
ID_TAG_AUTH_HOME_STREAM_NUM_USERS = "auth_home_stream_num_users_" #append idea id
ID_TAG_AUTH_HOME_USER_IDEAS = "auth_home_user_ideas"
#   Feedback chat window ID
ID_TAG_FEEDBACK_CHAT = "feedback_chat_id"


# Configurable text for system messages
USER_ACTION_FRIENDSHIP_ADDED = "Friend has been added."
USER_ACTION_FRIENDSHIP_ADD_ERROR = "Error adding friend."
USER_ACTION_FRIENDSHIP_REMOVED = "Friend removed."


# Search functionality constants
AUTH_HOME_IDEAS_PER_PAGE = 10
