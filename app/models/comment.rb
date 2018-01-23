class Comment < ApplicationRecord
  belongs_to :event
  validates :comment, presence: true
end
