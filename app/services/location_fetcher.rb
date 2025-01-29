require 'httparty'
require 'uri'

class LocationFetcher
  def self.fetch_coordinates(location_name)
    # Encode the location name to ensure it's URL-safe
    encoded_location = URI.encode_www_form_component(location_name)

    # Correct URL formatting with string interpolation
    url = "https://geocode.maps.co/search?q=#{encoded_location}&api_key=679a79f060343775646546dej0785d0"

    # Send GET request to the API
    response = HTTParty.get(url)
    Rails.logger.info("Geocode API Response: #{response.body}")

    # Check if the response is valid and contains latitude and longitude
    # Since the response is an array, we need to access the first result (index 0)
    first_result = response.parsed_response.first

    if first_result && first_result["lat"].to_f != 0.0 && first_result["lon"].to_f != 0.0
      # Return valid coordinates
      { latitude: first_result["lat"].to_f, longitude: first_result["lon"].to_f }
    else
      # Handle case where no valid coordinates were found
      Rails.logger.error("Failed to fetch coordinates for location: #{location_name}")
      nil
    end
  end
end
