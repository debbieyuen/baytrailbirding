# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'application#index'
  get '/locations', to: 'application#show'
  get '/tips', to: 'application#tips'
  get '/ebird/birds', to: 'ebird#birds'
  get '/ebird/bird', to: 'ebird#bird'
  get '/ebird/hotspots', to: 'ebird#hotspots'
  get '/ebird/locations', to: 'ebird#locations'
  get '/donation', to: 'application#donation'
end
