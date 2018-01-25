class Event < ApplicationRecord
  has_many :comments
  has_many :members
  belongs_to :user, :foreign_key => "uid"
  validates :title, presence: true
  validates :detail, presence: true
end
