class LoginController < ApplicationController
  def create
    @auth = request.env['omniauth.auth']
      
    #_, domain = @auth.uid.split('@')
    #client = Mastodon::REST::Client.new(base_url: "https://#{domain}", bearer_token: @auth.credentials.token)
    #client.create_status('ｵﾌﾄﾞｩｰﾝにログインしますた')
  end
end
