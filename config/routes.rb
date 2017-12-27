Rails.application.routes.draw do

  # get 'users/index'
  resources :users, only: [:index] do
  	member do
  		get 'manage_shops'
  		patch 'update_shops'
  	end
  end

  devise_for :admins
	root 'shops#index'

  resources :shops
	resources :categories

	namespace :api do
		namespace :v1 do

			devise_for :users, controllers: {
				sessions: "api/v1/sessions",
				registrations: "api/v1/registrations",
				passwords: "api/v1/passwords",
				confirmations: "api/v1/confirmations"
			}

			post 'users/social_login'

			get 'categories', to: 'categories#index'

			resources :shops , only: [:index, :show] do
				collection do
					get 'search'
					get 'favourites'
					get 'places'
				end
				member do
					post 'favourite', to: 'shops#add_favourite'
					delete 'favourite', to: 'shops#remove_favourite'
				end
				resources :reviews, except: [:show, :edit, :new] do
					member do
						post 'reply'
					end
				end
			end

		end
	end
end
