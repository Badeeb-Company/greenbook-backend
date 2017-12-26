json.shops @shops do |shop|
	# if shop.id
		json.extract! shop, :id, :google_place_id, :name, :rate, :main_photo_url
		json.num_of_reviews shop.reviews.size
		json.location do
			json.extract! shop, :long, :lat, :address
		end
	# else
	# 	json.id nil
	# 	json.google_place_id shop.place.place_id
	# 	json.name shop.place.name
	# 	json.rate 0
	# 	json.main_photo_url shop.place.icon

	# 	json.num_of_reviews 0

	# 	json.location do
	# 		json.extract! shop.place, :lat, :lng, :vicinity
	# 	end
	# end
end