class Event < ApplicationRecord
  has_many :comments
  has_many :members
  validates :title, presence: true
  validates :detail, presence: true
end
