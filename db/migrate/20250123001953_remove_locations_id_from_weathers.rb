class RemoveLocationsIdFromWeathers < ActiveRecord::Migration[6.0]
  def change
    remove_column :weathers, :locations_id, :integer
  end
end
