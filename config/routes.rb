Rails.application.routes.draw do

  if ENV["API_GQL_ENDPOINT"].present?
    mount GraphiQL::Rails::Engine, at: "/api_gql_explorer", graphql_path: ENV["API_GQL_ENDPOINT"]
  end

  mount RailsAdmin::Engine => '/', as: 'rails_admin'
end
