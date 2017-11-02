json.favourites @favourites do |favourite|
	json.partial! "shop", shop: favourite
end