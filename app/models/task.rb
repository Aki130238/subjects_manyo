class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    scope :sorted, -> { order(created_at: :DESC) }
    scope :expsorted, -> { order(expiration_out: :DESC) }
    # scope :priority, -> { order(priority: :DESC) }
    scope :wheretitle, -> (params_t){ where("title LIKE ?", "%#{ (params_t) }%") }
    scope :wherestatus, -> (params_s){ where("status LIKE ?", "%#{ (params_s) }%") }
    scope :wheres, -> (params_t, params_s){ where("title LIKE ? and status LIKE ?", "%#{ (params_t) }%", "%#{ (params_s) }%") }
    def self.priority_order(direction = "DESC")
        order("
            CASE
              WHEN priority = '高' THEN '1'
              WHEN priority = '中' THEN '2'
              WHEN priority = '低' THEN '3'
            END #{direction}"
            )
      
    end
end
