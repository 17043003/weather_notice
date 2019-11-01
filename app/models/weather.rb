class Weather < ApplicationRecord
    def self.get_weather(place)
        find_by(place: place)
    end

    def self.mail_to_user
        
    end
end
