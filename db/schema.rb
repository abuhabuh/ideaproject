# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111120014655) do

  create_table "admin_messages", :force => true do |t|
    t.string   "text"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_messages", ["user_id"], :name => "index_admin_messages_on_user_id"

  create_table "chat_messages", :force => true do |t|
    t.integer  "idea_id"
    t.string   "text"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chat_messages", ["idea_id"], :name => "index_chat_messages_on_idea_id"
  add_index "chat_messages", ["user_id"], :name => "index_chat_messages_on_user_id"

  create_table "deals", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "vendor_name"
    t.string   "location"
    t.string   "purchase_link"
    t.decimal  "price",                   :precision => 9, :scale => 2
    t.decimal  "original_price",          :precision => 9, :scale => 2
    t.decimal  "percent_off",             :precision => 4, :scale => 2
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "deal_photo_file_name"
    t.string   "deal_photo_content_type"
    t.integer  "deal_photo_file_size"
    t.datetime "deal_photo_updated_at"
  end

  add_index "deals", ["user_id"], :name => "index_deals_on_user_id"

  create_table "event_pictures", :force => true do |t|
    t.integer  "picture_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_pictures", ["event_id"], :name => "index_event_pictures_on_event_id"
  add_index "event_pictures", ["picture_id"], :name => "index_event_pictures_on_picture_id"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "location"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "visibility"
    t.integer  "status"
    t.integer  "num_users_joined"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["friend_id"], :name => "index_friendships_on_friend_id"
  add_index "friendships", ["user_id", "friend_id"], :name => "index_friendships_on_user_id_and_friend_id", :unique => true
  add_index "friendships", ["user_id"], :name => "index_friendships_on_user_id"

  create_table "idea_deals", :force => true do |t|
    t.integer  "idea_id"
    t.integer  "deal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "idea_deals", ["deal_id"], :name => "index_idea_deals_on_deal_id"
  add_index "idea_deals", ["idea_id"], :name => "index_idea_deals_on_idea_id"

  create_table "idea_events", :force => true do |t|
    t.integer  "idea_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "idea_events", ["event_id"], :name => "index_idea_events_on_event_id"
  add_index "idea_events", ["idea_id"], :name => "index_idea_events_on_idea_id"

  create_table "ideas", :force => true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "creator"
    t.integer  "num_users_joined"
    t.integer  "featured",           :default => 0
  end

  create_table "pictures", :force => true do |t|
    t.string   "description"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_auths", :force => true do |t|
    t.string   "token"
    t.string   "provider_id"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_events", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_events", ["event_id"], :name => "index_user_events_on_event_id"
  add_index "user_events", ["user_id"], :name => "index_user_events_on_user_id"

  create_table "user_ideas", :force => true do |t|
    t.boolean  "invited"
    t.integer  "user_id"
    t.integer  "idea_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_ideas", ["idea_id"], :name => "index_user_ideas_on_idea_id"
  add_index "user_ideas", ["user_id"], :name => "index_user_ideas_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                   :default => "", :null => false
    t.string   "encrypted_password",       :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                           :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "user_name"
    t.string   "location"
    t.date     "dob"
    t.string   "profile_pic_file_name"
    t.string   "profile_pic_content_type"
    t.integer  "profile_pic_file_size"
    t.datetime "profile_pic_updated_at"
    t.string   "description"
    t.string   "interests"
    t.integer  "auth_page_layout",                        :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  add_foreign_key "admin_messages", "users", :name => "admin_messages_user_id_fk"

  add_foreign_key "chat_messages", "ideas", :name => "chat_messages_idea_id_fk"
  add_foreign_key "chat_messages", "users", :name => "chat_messages_user_id_fk"

  add_foreign_key "deals", "users", :name => "deals_user_id_fk"

  add_foreign_key "friendships", "users", :name => "friendships_friend_id_fk", :column => "friend_id"
  add_foreign_key "friendships", "users", :name => "friendships_user_id_fk"

  add_foreign_key "idea_deals", "deals", :name => "idea_deals_deal_id_fk"
  add_foreign_key "idea_deals", "ideas", :name => "idea_deals_idea_id_fk"

  add_foreign_key "idea_events", "events", :name => "idea_events_event_id_fk"
  add_foreign_key "idea_events", "ideas", :name => "idea_events_idea_id_fk"

  add_foreign_key "user_auths", "users", :name => "user_auths_user_id_fk"

  add_foreign_key "user_events", "events", :name => "user_events_event_id_fk"
  add_foreign_key "user_events", "users", :name => "user_events_user_id_fk"

  add_foreign_key "user_ideas", "ideas", :name => "user_ideas_idea_id_fk"
  add_foreign_key "user_ideas", "users", :name => "user_ideas_user_id_fk"

end
