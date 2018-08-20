class Event < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :members, dependent: :destroy
  belongs_to :user, class_name: "User", foreign_key: "uid", optional: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :detail, presence: true
  validates :limit, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 200 }
    
  validates :url, allow_blank: true, format: /\A#{URI::regexp(%w(http https))}\z/
  validate :date_check
  
  def date_check
    if close_time.blank?
      errors.add(:close_time, "を入力してください")
    end
  end
  
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
  
  def self.search_api(params, user)
    result = Event.search(user, false)
    result = result.where(id: params[:id]) if params[:id].present?
    result = result.where("title like ?",  "%#{params[:title]}%") if params[:title].present?
    result = result.where("id >= ?", params[:id_from]) if params[:id_from].present?
    result = result.where("id <= ?", params[:id_to]) if params[:id_to].present?
    result = result.where("updated_at >= ?", params[:update_from].to_time) if params[:update_from].present?
    result = result.where("updated_at  <= ?", params[:update_to].to_time) if params[:update_to].present?
    if params[:limit].present?
      if params[:limit].to_i > 20
        result = result.limit(20)
      else
        result = result.limit(params[:limit])
      end
    else
      result = result.limit(10)
    end
    result
  end
end
