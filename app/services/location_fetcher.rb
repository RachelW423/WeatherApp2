class LocationFetcher
  API_KEY = '129845906369504e15975493x7305'

  def self.fetch_coordinates(location)
    url = "https://geocode.xyz/#{location.name}?json=1&auth=#{API_KEY}"

    response = HTTParty.get(url)

    if response.success? && response.parsed_response["latt"] && response.parsed_response["longt"]
      { latitude: response.parsed_response["latt"], longitude: response.parsed_response["longt"] }
    else
      nil
    end
  end
end
