class NotificationMailer < ApplicationMailer
    default from: "ishizuka533725@gmail.com"

    def send_notification_mail(user)
        @user = user
        mail(
            subject: "今日の天気", #メールのタイトル
            to: @user.email #宛先
        )   do |format|
                format.text
            end
    end
end
