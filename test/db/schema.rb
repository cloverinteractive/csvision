ActiveRecord::Schema.define do
  create_table "products", :force => true do |t|
    t.string   "name",                                                         :null => false
    t.text     "description",                                                  :null => false
    t.string   "permalink",                                                    :null => false
    t.boolean  "published",                                 :default => false, :null => false
    t.decimal  "price",       :precision => 8, :scale => 2, :default => 0.0,   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string  "nickname"
    t.integer "points"
  end
end
