class WeatherFetcher
  BASE_URL = 'https://api.open-meteo.com/v1/forecast'

  def self.fetch_weather_for_location(location)
    url = "#{BASE_URL}?latitude=#{location.latitude}&longitude=#{location.longitude}&daily=temperature_2m_max,temperature_2m_min&temperature_unit=fahrenheit&wind_speed_unit=mph&precipitation_unit=inch&timeformat=unixtime"
    response = HTTParty.get(url)
     Rails.logger.info("Weather API Response: #{response.inspect}")

    if response.success?
      forecast_data = response.parsed_response["daily"]
  
      forecast_data["time"].each_with_index do |date, index|
        Weather.create!(
          location_id: location.id,
          date: Time.at(forecast_data["time"][index]).utc,  
          high: forecast_data["temperature_2m_max"][index],
          low: forecast_data["temperature_2m_min"][index],
        )
      end
    else
      Rails.logger.error("Failed to fetch weather data.")
    end
  end

  private


end
