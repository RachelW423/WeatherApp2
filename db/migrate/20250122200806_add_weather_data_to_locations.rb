class AddWeatherDataToLocations < ActiveRecord::Migration[8.0]
  def change
    add_column :locations, :weather_data, :text
  end
end
