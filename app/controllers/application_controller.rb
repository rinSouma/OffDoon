class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #共通定数
  $NAME_VIEW = {0 => "全体公開", 1 => "ログインユーザにのみ公開", 2 => "同インスタンスのユーザにのみ公開"}
  $NAME_JOIN = {1 => "参加希望", 2 => "検討中", 3 => "不参加"}  
  
  def get_user_info
    #トークンを使ってユーザ情報を取得（できていればログイン済み）
    if session[:uid] != nil
      _, domain = session[:uid].split('@')
      client = Mastodon::REST::Client.new(base_url: "https://#{domain}", bearer_token: session[:token])
      begin
        user_data = client.account(session[:id])
        #取得したユーザーデータをDBに登録する
        if user = User.find_or_initialize_by(uid: session[:uid])
          user.update_attributes(
            uid: session[:uid],
            display_name: user_data.display_name,
            avatar: user_data.avatar_static,
            url: user_data.url,
            domain: domain
          )
        end
        @user = User.find_by(uid: session[:uid])
        rescue => e
          p e
      end
    end
    
    def toot_for_mastodon(message)
      client = Mastodon::REST::Client.new(base_url: "https://#{@user.domain}", bearer_token: session[:token])
      client.create_status(message)
    end
  end
end
