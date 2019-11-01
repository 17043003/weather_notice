class InformationController < ApplicationController
  def index
    @information = Weather.all
  end

  def show
    @weather = Weather.get_weather(params[:search_place])
    # @weather = weather[:weather]
    @user = User.find_by(name: "石塚")
    NotificationMailer.send_notification_mail(@user).deliver_later
  end
end
