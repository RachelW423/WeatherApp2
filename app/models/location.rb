class Location < ApplicationRecord
    
    has_many :weathers
    validates :name, presence: true
end
