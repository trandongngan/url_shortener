# frozen_string_literal: true

Rails.application.routes.draw do
  root to: proc { [404, {}, ["Not found."]] }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      unless %w[production].include?(Rails.env)
        resources :api_docs, only: [:index]
      end

      post 'encode'  => 'short_links#encode'
      post 'decode' => 'short_links#decode'
    end
  end
end
