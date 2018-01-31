class User < ApplicationRecord
  self.primary_key = 'uid'
  has_many :members , foreign_key: "uid"
  has_many :comments , foreign_key: "uid"
  has_many :events , class_name: "Event", foreign_key: "uid"
end
