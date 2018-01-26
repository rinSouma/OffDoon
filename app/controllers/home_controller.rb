class HomeController < ApplicationController
  def index
    @events = Event.all.order(created_at: 'desc')
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
  end
end
