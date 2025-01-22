class Weather < ApplicationRecord
  belongs_to :locations
  validates :date, :high, :low, presence: true
end
