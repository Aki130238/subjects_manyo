class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    scope :sorted, -> { order(created_at: :desc) }
    scope :expsorted, -> { order(expiration_out: :desc) }
    scope :wheretitle, -> (params_t){ where("title LIKE ?", "%#{ (params_t) }%") }
    scope :wherestatus, -> (params_s){ where("status LIKE ?", "%#{ (params_s) }%") }
    scope :wheres, -> (params_t, params_s){ where("title LIKE ? and status LIKE ?", "%#{ (params_t) }%", "%#{ (params_s) }%") }
end
