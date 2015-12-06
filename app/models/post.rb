class Post < ActiveRecord::Base
  # validates :user_id, presence: true
  # validates :content, presence: true

  # This will allow order_by_created_at to work, as well as order_by_created_at(:asc)
  scope :order_by_created_at, -> (direction = :desc) { order(created_at: direction) }
  validates :content, presence: true
  validates :title, presence: true
  has_many :replies, dependent: :destroy
  belongs_to :user
  belongs_to :group
end
