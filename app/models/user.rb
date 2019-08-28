class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_secure_password
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }, on: :new
  before_destroy :errors_destroy

  private

  def errors_destroy
    throw :abort if User.where(admin: true).count == 1
  end

end
