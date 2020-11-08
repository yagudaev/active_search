Rails.application.routes.draw do
  resources :pages do
    collection do
      get :import
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
