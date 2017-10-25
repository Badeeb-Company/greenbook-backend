class Api::V1::ShopsController < Api::V1::BaseController

	def search
		@shops = Shop.all.order("name asc")
		# category_id = params[:category_id]
		# lat = params[:lat]
		# lng = params[:lng]
		# if !valid_location?(lat, lng)
		# 	render_unprocessable('Invalid location') and return
		# end
		# @shops = Shop.within(5, :origin => [lat, lng])
		# 	.where(category_id: category_id)
		# 	.order("name asc")
	end


	private

	def valid_location?(lat, lng)
		lat && lng && (-90..90).include?(lat.to_f) && (-180..180).include?(lng.to_f)
	end

end