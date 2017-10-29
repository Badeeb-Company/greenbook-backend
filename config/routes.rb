Rails.application.routes.draw do

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

			get 'categories', to: 'categories#index'

			resources :shops , only: [] do
				collection do
					get 'search'
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
