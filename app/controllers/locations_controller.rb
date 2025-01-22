class LocationsController < ApplicationController
  
  def new
    @location = Location.new
    coordinates = LocationFetcher.fetch_coordinates(@location)
  
    if coordinates
      @location.latitude = coordinates[:latitude]
      @location.longitude = coordinates[:longitude]
  
      if @location.save
        weather_data = WeatherFetcher.fetch_weather_for_location(@location.latitude, @location.longitude)
        @location.update(weather_data: weather_data.to_json)
        
        @weather_data = JSON.parse(@location.weather_data) if @location.weather_data.present?

        redirect_to location_path(@location)
      else
        render :new
      end
    else
      flash[:alert] = "Unable to fetch location coordinates. Please check the address."
      render :new
    end
  end
end 