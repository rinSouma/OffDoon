module Api
  module V1
    class Api::V1::EventController < ApplicationController
      def index
        #ヘッダに設定されたトークンからユーザ情報を取得
        @user = User.find_by(token: request.headers[:HTTP_TOKEN])
        @events = Event.search(@user, false).where("detail like ?","%"+params[:detail]+"%")
        render json: @events.to_json(:include => [:members, :comments])
      end
    end
  end
end