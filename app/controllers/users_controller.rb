class UsersController < ApplicationController
  def index
  	@users = User.paginate(:page => params[:page], :per_page => 10).order("name ASC")
  end

  def manage_shops
  	@user = User.find(params[:id])
  end

  def update_shops
  	@user = User.find(params[:id])
	if @user.update(shops_params)
	  redirect_to users_path, notice: 'User shops updated.'
	else
	  render :manage_shops
	end
  end

  def shops_params
      params.require(:user).permit(shop_admins_attributes: [:id, :shop_id, :_destroy])
    end
end
