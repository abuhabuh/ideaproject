# CONSTANTS FOR IDEA PROJECT

##########################################
# Commitment Constants
##########################################
NUM_COMMITS_PER_MONTH = 4


##########################################
# Featured ranking and grouping constants
##########################################
NOT_FEATURED = 0 # not featured is 0, featured db column is integer and all values can be ordered by importance


##########################################
# Pusher chat config & Chat constants
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
CHAT_TYPE_IDEA = 0
CHAT_TYPE_EVENT = 1


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
IDEA_STREAM_VIEW_ONLY = 0
IDEA_STREAM_ALL_ACTIVE = 1
IDEA_STREAM_NO_PREVIEW = 2

##########################################
# JS ID tags
##########################################
AUTH_HOME_IDEA_ACTION_PREVIEW = 'JS_idea_rowaction_preview'

##########################################
# AJAX ID tags
##########################################
#   User list view page
ID_TAG_USER_LIST_USER_ROW = "AJAX_user_list_row_id_" #append user id
ID_USER_PICTURE_LIST_CONTAINER = 'AJAX_user_picture_list_container' # identifies user picture list container (used in 'kick em' functionality)

#   Main authenticated home page
ID_TAG_AUTH_HOME_STREAM_ADD_IDEA_BUTTON = "AJAX_auth_home_stream_add_idea_button_id_" #append idea id
ID_TAG_AUTH_HOME_STREAM_DONE_IDEA_BUTTON = "AJAX_auth_home_stream_done_idea_button_id_" #append idea id
ID_TAG_AUTH_HOME_STREAM_NUM_USERS = "AJAX_auth_home_stream_num_users_" #append idea id
ID_TAG_AUTH_HOME_USER_IDEAS = "AJAX_auth_home_user_ideas"
ID_TAG_AUTH_HOME_IDEA_PREVIEW_GOAL = "AJAX_auth_home_idea_preview_goal"

#   Idea view page
ID_TAG_IDEA_CHAT = "AJAX_idea_view_chat_id_" #append idea id
ID_TAG_IDEA_EDIT_LINK = "AJAX_idea_edit_link" 
#     Feedback / Idea chat window ID
ID_TAG_FEEDBACK_CHAT = "AJAX_feedback_chat_id"
ID_TAG_IDEA_USER = "AJAX_idea_user_" # Identifies users that are in left_nav user list as online / offline: append user id 
#     Commitment status tag
ID_TAG_IDEA_VIEW_COMMITMENT_STATUS = 'AJAX_idea_view_commitment_status'
#     Chat tags
ID_TAG_IDEA_CHAT_INPUT_AREA = 'AJAX_idea_chat_input_area'
ID_TAG_IDEA_CHAT_USER_LIST = 'AJAX_idea_chat_user_list'
ID_TAG_CHAT_USER_JOINED_STRING = 'Joined'
ID_TAG_CHAT_USER_VIEWING_STRING = 'Viewing'
ID_TAG_CHAT_USER_COMMITTED_STRING = 'Committed'

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
INPUT_BOX_ADD_IDEA = "What do you want to do with friends?"
INPUT_BOX_SEARCH_IDEAS = "Enter text to search"
BUTTON_JOIN_IDEA = "Add to Your List!"
BUTTON_CHAT_IDEA = "View Idea Details"
BUTTON_DONE_IDEA = "Done it already?"
JOIN_IDEA_SUCCESS_TEXT = "Idea Added!"
DONE_IDEA_SUCCESS_TEXT = "I've done this!"

##########################################
# DATABASE / SOLR Search functionality constants
##########################################
AUTH_HOME_IDEAS_PER_PAGE = 10
DEALS_PER_PAGE = 8
IDEA_LAYOUT_BLOCK_NUM_CHATS = 4
IDEA_LAYOUT_PREVIEW_NUM_CHATS = 6
IDEA_KICK_USERS_NUM_PER_PAGE = 6


##########################################
# Page Layout Constants
##########################################
PAGE_LAYOUT_AUTH_HOME_BLOCK_NORMAL = 0
PAGE_LAYOUT_AUTH_HOME_BLOCK = 1
PAGE_LAYOUT_AUTH_HOME_MAGAZINE = 2
PAGE_LAYOUT_AUTH_HOME_STREAM = 3

##########################################
# Ideas Constants
##########################################
#   Time goal - the time range someone's idea goes for
IDEA_TIMEGOAL_THIS_WEEK = 0
IDEA_TIMEGOAL_THIS_MONTH = 1
IDEA_TIMEGOAL_THIS_YEAR = 2
IDEA_TIMEGOAL_ANYTIME = 3
IDEA_TIMEGOAL_THIS_WEEK_STR = 'this week'
IDEA_TIMEGOAL_THIS_MONTH_STR = 'this month'
IDEA_TIMEGOAL_THIS_YEAR_STR = 'this year'
IDEA_TIMEGOAL_ANYTIME_STR = 'anytime'
#   User's idea status
USER_IDEA_STATUS_SHARING = 0
USER_IDEA_STATUS_INVITED = 1
USER_IDEA_STATUS_LIKE = 2 # TODO: maybe use this? not implemented yet
USER_IDEA_STATUS_DONE_IDEA = 3 # Separate column done_it also keeps tabs on if user has done idea 
#   Idea join type specifying type of idea relationship being established
IDEA_ASSC_ADD_IDEA = 0
IDEA_ASSC_DONE_IDEA = 1


##########################################
# Events Constants
##########################################
#   EVENT TABLE
EVENT_STATUS_CREATED = 0
EVENT_STATUS_COMPLETED = 1
#   USERS_EVENT TABLE
USER_EVENT_STATUS_ATTENDING = 0
USER_EVENT_STATUS_MAYBE = 1
USER_EVENT_STATUS_NOT_ATTENDING = 2
USER_EVENT_STATUS_LIKE = 3
USER_EVENT_STATUS_INVITED = 4
USER_EVENT_STATUS_ADMIN = 5
#   USERS_EVENT TABLE
USER_EVENT_VISIBILITY_PUBLIC = 0
USER_EVENT_VISIBILITY_FRIENDS = 1
USER_EVENT_VISIBILITY_INVITE_ONLY = 2
