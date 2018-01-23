class Event < ApplicationRecord
  has_many :comments
  validates :title, presence: true
  validates :detail, presence: true
end
