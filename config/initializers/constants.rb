# CONSTANTS FOR IDEA PROJECT


##########################################
# Featured ranking and grouping constants
##########################################
NOT_FEATURED = 0; # not featured is 0 where as everything else is featured and can be ordered by integer


##########################################
# Pusher chat config
##########################################
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


##########################################
# Stream View Constants
##########################################
STREAM_VIEW_PUBLIC = 'public'
STREAM_VIEW_FRIENDS = 'friends'
STREAM_VIEW_SEARCH = 'search'
STREAM_VIEW_FEATURED = 'featured'

# idea stream rendering 
PIC_VIEW_TYPE_IDEA = 'idea_pic'
PIC_VIEW_TYPE_USER = 'user_pic'
IDEA_STREAM_VIEW_ONLY_TRUE = 'true'
IDEA_STREAM_VIEW_ONLY_FALSE = 'false'



##########################################
# AJAX ID tags
##########################################
#   User list view page
ID_TAG_USER_LIST_USER_ROW = "AJAX_user_list_row_id_" #append user id

#   Main authenticated home page
ID_TAG_AUTH_HOME_STREAM_IDEA_ACTION = "AJAX_auth_home_stream_idea_action_id_" #append idea id
ID_TAG_AUTH_HOME_STREAM_NUM_USERS = "AJAX_auth_home_stream_num_users_" #append idea id
ID_TAG_AUTH_HOME_USER_IDEAS = "AJAX_auth_home_user_ideas"

#   Idea view page
ID_TAG_IDEA_CHAT = "AJAX_idea_view_chat_id_" #append idea id
ID_TAG_IDEA_EDIT_LINK = "AJAX_idea_edit_link" 
#     Feedback / Idea chat window ID
ID_TAG_FEEDBACK_CHAT = "AJAX_feedback_chat_id"
ID_TAG_IDEA_USER = "AJAX_idea_user_" # Identifies users that are in left_nav user list as online / offline: append user id 
ID_TAG_IDEA_CHAT_INPUT_AREA = 'AJAX_idea_chat_input_area'
ID_TAG_IDEA_CHAT_USER_LIST = 'AJAX_idea_chat_user_list'

ID_TAG_CHAT_USER_JOINED_STRING = 'Joined'
ID_TAG_CHAT_USER_VIEWING_STRING = 'Viewing'

#   Page markers to tell shared AJAX function (like add_idea_id.js.erb which is share across
#     main auth page and idea view page) which page it is on so it can execute correct 
#     action batch.
ID_TAG_HOME_AUTH_PAGE = "AJAX_home_auth_page_id"
ID_TAG_IDEA_VIEW_PAGE = "AJAX_idea_view_page_id"

#   Deal markers
ID_TAG_IDEA_DEALS_LIST_CONTAINER = 'AJAX_idea_deals_list_container'
ID_TAG_DEAL_ITEM = 'AJAX_deal_item_' #append deal id
ID_TAG_DEAL_ITEM_ACTION_BUTTON = 'AJAX_deal_item_action_button_' #append deal id


##########################################
# Configurable text for system messages
##########################################
USER_ACTION_FRIENDSHIP_ADDED = "Friend has been added."
USER_ACTION_FRIENDSHIP_ADD_ERROR = "Error adding friend."
USER_ACTION_FRIENDSHIP_REMOVED = "Friend removed."
USER_ACTION_NEW_IDEA_CREATED = "Your new idea was created and saved."
INPUT_BOX_ADD_IDEA = "What do you want to do?"
INPUT_BOX_SEARCH_IDEAS = "Enter text to search"
BUTTON_JOIN_IDEA = "Join Idea!"
BUTTON_CHAT_IDEA = "Go Chat!"


##########################################
# Search functionality constants
##########################################
AUTH_HOME_IDEAS_PER_PAGE = 10
DEALS_PER_PAGE = 8
