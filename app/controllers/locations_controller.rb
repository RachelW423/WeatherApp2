class LocationsController < ApplicationController
  
  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
  
    coordinates = LocationFetcher.fetch_coordinates(@location.name)
  
    if coordinates && coordinates[:latitude] != 0.0 && coordinates[:longitude] != 0.0
      @location.latitude = coordinates[:latitude]
      @location.longitude = coordinates[:longitude]
  
      if @location.save
        # Fetch weather data for the location once
        weather_data = WeatherFetcher.fetch_weather_for_location(@location)
  
        # Store the weather data in the location
        @location.update(weather_data: weather_data.to_json)
  
        # Parse the weather data (convert to Hash if it's stored as a string)
        parsed_weather_data = JSON.parse(@location.weather_data) if @location.weather_data.is_a?(String)
  
        if parsed_weather_data.is_a?(Hash) && parsed_weather_data["daily"]
          daily_data = parsed_weather_data["daily"]
  
          if daily_data["time"].is_a?(Array) &&
             daily_data["temperature_2m_max"].is_a?(Array) &&
             daily_data["temperature_2m_min"].is_a?(Array) &&
             daily_data["weathercode"].is_a?(Array)
            
            daily_data["time"].each_with_index do |timestamp, index|
              Weather.create!(
                location_id: @location.id,
                date: timestamp,  # Use the timestamp for each day's weather
                high: daily_data["temperature_2m_max"][index],
                low: daily_data["temperature_2m_min"][index]
              )
            end
          end
        end
  
        # Redirect to the location show page
        redirect_to location_path(@location)
      else
        Rails.logger.error("Failed to save location")
        render :new
      end
    else
      Rails.logger.error("Failed to fetch coordinates for #{@location.name}")
      flash[:alert] = "Unable to fetch location coordinates. Please check the address."
      render :new
    end
  end
  
  

  def show
    @location = Location.find(params[:id])
    weather_data = @location.weather_data.present? ? JSON.parse(@location.weather_data) : nil
    
  end
  
  def index
    @locations = Location.all
  end

  private

  def location_params
    params.require(:location).permit(:name)
  end
end