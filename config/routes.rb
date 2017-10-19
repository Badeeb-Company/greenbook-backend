Rails.application.routes.draw do

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
			get 'shops/search', to: 'shops#search'
		end
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
