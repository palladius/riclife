# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100725084042) do

  create_table "apps", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "person_id"
    t.string   "url"
    t.string   "local_path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon"
  end

  create_table "calendars", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "private"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.boolean  "external"
    t.string   "abbrev"
    t.string   "icon_path"
    t.string   "timezone",    :default => "Ireland/Dublin"
    t.integer  "vote",        :default => 59
    t.string   "tags"
    t.boolean  "active",      :default => true
    t.boolean  "main",        :default => false
    t.string   "color",       :default => "navy"
  end

  create_table "cities", :force => true do |t|
    t.string   "nomecitta"
    t.string   "sigla"
    t.string   "regione"
    t.integer  "id_pseudoid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.string   "body",                           :default => ""
    t.datetime "created_at",                                     :null => false
    t.integer  "commentable_id",                 :default => 0,  :null => false
    t.string   "commentable_type", :limit => 15, :default => "", :null => false
    t.integer  "user_id",                        :default => 0,  :null => false
  end

  add_index "comments", ["user_id"], :name => "fk_comments_user"

  create_table "countries", :force => true do |t|
    t.string   "code",        :limit => 2
    t.string   "name"
    t.string   "description"
    t.boolean  "favourite",                :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_attendees", :force => true do |t|
    t.integer  "event_id"
    t.integer  "person_id"
    t.boolean  "confirmed",  :default => false
    t.boolean  "busy",       :default => true
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_types", :force => true do |t|
    t.string   "name"
    t.string   "icon"
    t.boolean  "active"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "summary"
    t.text     "description"
    t.integer  "venue_id"
    t.string   "location"
    t.datetime "tstart"
    t.datetime "tend"
    t.boolean  "repeats"
    t.integer  "organizer_id"
    t.string   "url"
    t.string   "repeat_frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price"
    t.boolean  "private",          :default => false
    t.integer  "creator_id"
    t.integer  "event_type_id"
    t.string   "icon_path"
    t.integer  "calendar_id"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.integer  "vote",             :default => 59
    t.string   "tags"
    t.boolean  "active",           :default => true
  end

  create_table "friendships", :force => true do |t|
    t.integer  "person_id"
    t.integer  "followed_id"
    t.string   "notes"
    t.integer  "importance",  :default => 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tags",        :default => "friend"
    t.boolean  "visible",     :default => true
  end

  create_table "gms", :force => true do |t|
    t.string   "subject"
    t.text     "body"
    t.integer  "from_id"
    t.integer  "to_id"
    t.boolean  "unread",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     :default => true
    t.integer  "person_id"
  end

  create_table "gugol_calendars", :force => true do |t|
    t.string   "name"
    t.string   "calname",     :default => "_riclife"
    t.string   "color",       :default => "blue"
    t.string   "username",    :default => "CHANGEME@gmail.com"
    t.string   "password"
    t.text     "description"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hosts", :force => true do |t|
    t.string   "name"
    t.string   "ip"
    t.text     "notes"
    t.string   "os"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", :force => true do |t|
    t.integer  "person_id"
    t.integer  "app_id"
    t.string   "uid"
    t.text     "description"
    t.boolean  "validated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password"
    t.string   "login"
  end

  create_table "keyvals", :force => true do |t|
    t.string   "key"
    t.string   "val"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "libraries", :force => true do |t|
    t.string   "name"
    t.text     "notes"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loans", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.float    "quantity"
    t.string   "currency",     :default => "euro"
    t.integer  "user_from_id"
    t.integer  "user_to_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ower_id"
    t.boolean  "solved",       :default => false
    t.boolean  "starred",      :default => false
    t.integer  "creditor_id"
    t.string   "tags"
    t.integer  "recurs_days",  :default => 0
    t.integer  "loan_id"
    t.date     "date_start"
    t.date     "date_end"
    t.boolean  "active",       :default => true
    t.string   "type"
  end

  create_table "magic_urls", :force => true do |t|
    t.string   "url"
    t.text     "description"
    t.integer  "privacy",     :default => 1
    t.integer  "user_id"
    t.boolean  "active",      :default => true
    t.string   "type",        :default => "MagicUrl"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mailings", :force => true do |t|
    t.string   "subject"
    t.text     "content"
    t.datetime "delivered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "active"
    t.date     "deadline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.string   "icon_path"
    t.integer  "vote",        :default => 59
    t.string   "tags"
    t.integer  "relevance",   :default => 30
    t.integer  "progress",    :default => 0
    t.boolean  "completed",   :default => false
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "header"
    t.text     "body"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tags",       :default => "doc"
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "mobile"
    t.string   "location",          :default => "Dublin, Ireland"
    t.string   "organisation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.string   "photo_name"
    t.string   "email"
    t.boolean  "published",         :default => true
    t.integer  "relevance"
    t.string   "nickname"
    t.boolean  "starred",           :default => false
    t.boolean  "male"
    t.date     "birthday"
    t.integer  "venue_id"
    t.integer  "strength",          :default => 10
    t.integer  "dexterity",         :default => 10
    t.integer  "wisdom",            :default => 10
    t.integer  "intelligence",      :default => 10
    t.integer  "constitution",      :default => 10
    t.integer  "charisma",          :default => 10
    t.integer  "work_venue_id"
    t.boolean  "virtual",           :default => false
    t.string   "feed"
    t.integer  "sexappeal",         :default => 60
    t.integer  "vote",              :default => 59
    t.string   "tags"
    t.string   "created_by"
    t.string   "updated_by"
    t.string   "work_email"
    t.string   "pers_email"
    t.boolean  "goliard",           :default => false
    t.string   "goliardic_name"
    t.string   "nationality",       :default => "italian"
    t.integer  "country_id",        :default => 106
    t.string   "relational_status"
  end

  create_table "photo_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.integer  "photo_type_id"
    t.integer  "parent_id"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "date_due",    :default => '2009-11-29'
    t.boolean  "active",      :default => true
    t.boolean  "todo",        :default => true
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon_path"
    t.boolean  "main",        :default => false
    t.string   "color",       :default => "navy"
    t.boolean  "public",      :default => true
  end

  create_table "recipes", :force => true do |t|
    t.string   "name"
    t.text     "ingredients"
    t.text     "preparation"
    t.integer  "givenby_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ric_events", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean  "all_day"
    t.text     "description"
    t.string   "icon_path"
    t.boolean  "private",       :default => false
    t.string   "url"
    t.integer  "person_id"
    t.integer  "venue_id"
    t.integer  "event_type_id"
    t.integer  "calendar_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vote",          :default => 59
    t.string   "tags"
  end

  create_table "ricfiles", :force => true do |t|
    t.string   "host"
    t.string   "path"
    t.string   "URI"
    t.string   "tags"
    t.text     "metatags"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "sport_activities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "duration",    :default => 60
    t.integer  "person_id",   :default => 1
    t.integer  "calories"
    t.string   "activity"
    t.date     "date",        :default => '2010-03-21'
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                   :default => "passive"
    t.datetime "deleted_at"
    t.integer  "person_id"
    t.string   "last_login_place"
  end

  create_table "venue_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon_path",   :limit => nil
    t.string   "tags"
  end

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "url"
    t.integer  "venue_type_id"
    t.boolean  "private",       :default => false
    t.string   "icon_path"
    t.boolean  "active",        :default => true
    t.string   "mail"
    t.string   "phone"
    t.string   "tags"
    t.integer  "vote"
  end

  create_table "votes", :force => true do |t|
    t.boolean  "vote",                        :default => false
    t.datetime "created_at",                                     :null => false
    t.string   "voteable_type", :limit => 15, :default => "",    :null => false
    t.integer  "voteable_id",                 :default => 0,     :null => false
    t.integer  "user_id",                     :default => 0,     :null => false
  end

  add_index "votes", ["user_id"], :name => "fk_votes_user"

end
