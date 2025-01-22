class CreateWeathers < ActiveRecord::Migration[8.0]
  def change
    create_table :weathers do |t|
      t.references :locations, null: false, foreign_key: true
      t.date :date
      t.float :high
      t.float :low
      t.string :description
      t.string :string

      t.timestamps
    end
  end
end
