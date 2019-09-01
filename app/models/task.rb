class Task < ApplicationRecord
    belongs_to :user
    has_many :labellings, dependent: :destroy
    has_many :labels, through: :labellings
    validates :title, presence: true
    validates :content, presence: true
    scope :sorted, -> { order(created_at: :DESC) }
    scope :expsorted, -> { order(expiration_out: :DESC) }
    # scope :priority, -> { order(priority: :DESC) }
    scope :wheretitle, -> (params_t){ where("title LIKE ?", "%#{ (params_t) }%") }
    scope :wherestatus, -> (params_s){ where("status LIKE ?", "%#{ (params_s) }%") }
    def self.priority_order(direction = "DESC")
        order(Arel.sql("
            CASE
              WHEN priority = '高' THEN '1'
              WHEN priority = '中' THEN '2'
              WHEN priority = '低' THEN '3'
            END #{direction}"
            ))
    end
    paginates_per 10
end
