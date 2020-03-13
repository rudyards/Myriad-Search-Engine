Rails.application.routes.draw do
  get "card/gallery/:set/:id" => "card#gallery"
  get "card/:set/:id" => "card#show"
  get "card/:set/:id/:name" => "card#show"
  get "card" => "card#index"


  get "set/:id/verify_scans" => "set#verify_scans"
  get "set/:id" => "set#show"
  get "set" => "set#index"

  get "artist/:id" => "artist#show"
  get "artist" => "artist#index"

  get "format/:id" => "format#show"
  get "format" => "format#index"

  get "help/syntax" => "help#syntax"
  get "help/contact" => "help#contact"
  get "help/rules" => "help#rules"

  get "proxy" => "proxy#show"
  get "proxy/search" => "proxy#search"

  get "deck/:set/:id" => "deck#show"
  get "deck/:set/:id/download" => "deck#download"
  get "deck" => "deck#index"

  get "sealed" => "sealed#index"
  get "/" => "card#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
