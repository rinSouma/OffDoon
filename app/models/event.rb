class Event < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :members, dependent: :destroy
  belongs_to :user, class_name: "User", foreign_key: "uid", optional: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :detail, presence: true
  validates :limit, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 200 }
    
  validates :url, allow_blank: true, format: /\A#{URI::regexp(%w(http https))}\z/
  
  def self.search(user, date_flg)
    #ユーザ情報がある（ログインしている場合）はドメインチェック
    #そうでなければ全体公開のもののみ取得
    if user
      if date_flg
        where(["(events.view = ? or events.view = ? or (events.view = ? and events.uid like ?)) and events.date >= ?", 0, 1, 2, "%@"+user.domain, DateTime.now.yesterday.to_s(:db)])
      else
        where(["events.view = ? or events.view = ? or (events.view = ? and events.uid like ?)", 0, 1, 2, "%@"+user.domain])
      end
    else
      if date_flg
        where(['events.view = ? and events.date >= ?', 0, DateTime.now.yesterday.to_s(:db)])
      else
        where(['events.view = ?', 0])
      end
    end
  end
  
end
