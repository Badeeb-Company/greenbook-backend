json.user do
	json.extract! user, :id, :name, :email, :image_url, :token
	json.owned_shops user.shops do |shop|
		json.id shop.id
	end
end