class Comment < ApplicationRecord
  belongs_to :event
  belongs_to :user, :foreign_key => "uid"
  validates :comment, presence: true
end
