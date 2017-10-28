json.reviews @reviews do |review|

	json.extract! review, :id, :rate, :description, :created_at, :reply, :date_replied
	json.user do
		json.extract! review.user, :id, :name, :image_url
	end

end