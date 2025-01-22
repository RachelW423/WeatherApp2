class WeatherFetcher
  BASE_URL = 'https://api.open-meteo.com/v1/forecast'

  def self.fetch_weather_for_location(latitude, longitude)
    url = "#{BASE_URL}?latitude=#{latitude}&longitude=#{longitude}&daily=temperature_2m_max,temperature_2m_min,weathercode&timezone=America%2FNew_York"
    response = HTTParty.get(url)

    if response.success?
      forecast_data = response.parsed_response["daily"]
      forecast_data.each do |day|
        Weather.create!(
          location_id: location.id,
          date: day['date'],
          high: day['temperature_2m_max'],
          low: day['temperature_2m_min'],
          description: weather_description(day['weathercode'])
        )
      end
    else
      Rails.logger.error("Error fetching weather data: #{response.message}")
    end
  end

  def self.weather_description(code)
    case code
    when 0 then "Clear sky"
    when 1..2 then "Partly cloudy"
    when 3..4 then "Cloudy"
    when 5..7 then "Rainy"
    when 8..9 then "Snowy"
    else "Unknown"
    end
  end
end

  