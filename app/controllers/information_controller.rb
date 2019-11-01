class InformationController < ApplicationController
  def index
    @information = Weather.all
  end

  def show
    @weather = Weather.get_weather(params[:search_place])
    # @weather = weather[:weather]
    NotificationMailer.send_notification_mail(@user).deliver
  end
end
