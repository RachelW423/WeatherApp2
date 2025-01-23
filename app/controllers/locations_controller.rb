class LocationsController < ApplicationController
  
  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
  
    coordinates = LocationFetcher.fetch_coordinates(@location)
  
    if coordinates
      @location.latitude = coordinates[:latitude]
      @location.longitude = coordinates[:longitude]
  
      if @location.save
        weather_data = WeatherFetcher.fetch_weather_for_location(@location)
      
        @location.update(weather_data: weather_data.to_json)
      
        # Parse the JSON string back into a hash, just in case
        weather_data = JSON.parse(@location.weather_data) if @location.weather_data.is_a?(String)
      
        if weather_data.is_a?(Hash) && weather_data["daily"]
          daily_data = weather_data["daily"]
      
          if daily_data["time"].is_a?(Array) &&
             daily_data["temperature_2m_max"].is_a?(Array) &&
             daily_data["temperature_2m_min"].is_a?(Array) &&
             daily_data["weathercode"].is_a?(Array)
             daily_data["time"].each_with_index do |timestamp, index|
              Weather.create!(
                location_id: @location.id,
                date: daily_data["time"],
                high: daily_data["temperature_2m_max"][index],
                low: daily_data["temperature_2m_min"][index],
                description: weather_description(daily_data["weathercode"][index])
              )
            end
          end
        end
      
        redirect_to location_path(@location)
      else
        render :new
      end
      
    else
      flash[:alert] = "Unable to fetch location coordinates. Please check the address."
      render :new
    end
  end
  

  def show
    @location = Location.find(params[:id])
    weather_data = @location.weather_data.present? ? JSON.parse(@location.weather_data) : nil
  end
  
  

  private

  def location_params
    params.require(:location).permit(:name)
  end
end