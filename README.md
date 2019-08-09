# テーブル
## User
| 属性 | カラム名 |
----|---- 
| 立場 | position |
| 名前 | name |
| 外部キー | task_id |
## Task
| 属性 | カラム名 |
----|---- 
| 終了期限 | expiration_date |
| 優先順位 | priority |
| ステータス | status |
| 説明文 | content |
| 外部キー | label_id |
## Label
| 属性 | カラム名 |
----|---- 
| ラベル名 | label_name |
| 外部キー | task_id |

# スキーマ
```ruby schema.rb
  enable_extension "plpgsql"

  create_table "labels", force: :cascade do |t|
    t.integer "task_id"
    t.string "labelname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "position"
    t.integer "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.string "status"
    t.string "priority"
    t.text "content"
    t.datetime "expiration_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "label_id"
    t.index ["label_id"], name: "index_tasks_on_label_id"
  end

  add_foreign_key "tasks", "users"
  ```