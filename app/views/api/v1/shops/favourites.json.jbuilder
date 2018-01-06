json.favourites @favourites do |favourite|
	json.extract! favourite, :id, :google_place_id, :name, :rate, :main_photo_url
	json.num_of_reviews favourite.reviews.size
	json.location do
		json.extract! favourite, :long, :lat, :address
	end
end