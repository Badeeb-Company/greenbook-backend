class GooglePlacesApi

	def self.api_client
		@@api_client ||= GooglePlaces::Client.new(Rails.application.secrets.google_places_api_key)
	end

	def self.search_places(lat, lng, query)
		api_client.spots(lat, lng,
			:types => ['bakery', 'bar', 'cafe', 'church', 'meal_delivery', 'meal_takeaway', 'night_club', 'restaurant', 'shopping_mall', 'hair_care'],
			:name => query,
			:radius => 5000,
			:rankby => :distance)
	end

	def self.get_place_detail(place_id)
		begin
			api_client.spot(place_id)
		rescue HTTParty::ResponseError
			nil
		end
	end

end