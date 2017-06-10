Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'slides#index'
  resource :slides, except: [:show, :update, :edit]
  get '/slides/download/:id' => 'slides#download', as: 'download'
end
