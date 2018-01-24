class Menber < ApplicationRecord
  belongs_to :event
  validates :user, presence: true
  validates :kbn, presence: true
end
