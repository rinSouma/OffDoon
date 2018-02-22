module Api
  module V1
    class Api::V1::EventController < ApplicationController
      def index
        begin
          #ヘッダに設定されたトークンからユーザ情報を取得
          @user = User.find_by(token: request.headers[:HTTP_TOKEN])
          @events = Event.search_api(params).search(@user, false)
          render json: @events.to_json(:include => [:members, :comments])
        rescue=>e
          render json: {message: e.message}
        end
      end
    end
  end
end