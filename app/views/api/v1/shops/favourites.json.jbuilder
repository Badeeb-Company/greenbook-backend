json.favourites @favourites do |favourite|
	# json.extract! favourite, :id, :name, :rate, :phone_number, :main_photo_url
	# json.num_of_reviews favourite.reviews.size
	# json.location do
	# 	json.extract! favourite, :long, :lat, :address
	# end
	# json.photos favourite.photos do |photo|
	# 	json.extract! photo, :id, :photo_url
	# end
	# json.working_days favourite.working_days do |working_day|
	# 	json.extract! working_day, :day_name, :state
	# 	json.opened_at working_day.opened_at.strftime("%I:%M %p")
	# 	json.closed_at working_day.closed_at.strftime("%I:%M %p")
	# end

	json.extract! favourite, :id, :google_place_id, :name, :rate, :main_photo_url
	json.num_of_reviews favourite.reviews.size
	json.location do
		json.extract! favourite, :long, :lat, :address
	end
	
end