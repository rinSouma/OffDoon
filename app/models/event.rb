class Event < ApplicationRecord
  has_many :comments
  has_many :members
  belongs_to :user, class_name: "User", foreign_key: "uid", optional: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :detail, presence: true
  validates :limit, numericality: { only_integer: true, less_than_or_equal_to: 200 }
    
  validates :url, allow_blank: true, format: /\A#{URI::regexp(%w(http https))}\z/
end
