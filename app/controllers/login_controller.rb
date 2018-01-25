class LoginController < ApplicationController
  def create
    @auth = request.env['omniauth.auth']
    user_update(@auth)
    redirect_to root_path
    #_, domain = @auth.uid.split('@')
    #client = Mastodon::REST::Client.new(base_url: "https://#{domain}", bearer_token: @auth.credentials.token)
    #client.create_status('ｵﾌﾄﾞｩｰﾝにログインしますた')
  end
  
  private
    def user_update(auth)
      #DBにユーザーを登録（すでにある場合は更新）
      _, domain = auth.uid.split('@')
      uid = auth.extra.raw_info.acct << "@" << domain
      if user = User.find_or_initialize_by(uid: uid)
        user.update_attributes(
          uid: uid,
          display_name: auth.extra.raw_info.display_name,
          avatar: auth.extra.raw_info.avatar_static,
          url: auth.extra.raw_info.url,
          token: auth.credentials.token,
          domain: domain
        )
      end
      
      #セッションに登録
      session[:uid] = uid
    end
end
