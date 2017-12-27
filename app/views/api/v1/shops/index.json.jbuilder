json.shops @shops do |shop|
	json.extract! shop, :id, :google_place_id, :name, :rate, :main_photo_url
	json.num_of_reviews shop.reviews.size
	json.location do
		json.extract! shop, :long, :lat, :address
	end
end