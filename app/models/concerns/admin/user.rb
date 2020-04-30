module Admin::User
  extend ActiveSupport::Concern

  included do
    rails_admin do
      field :account_type
      field :active
      field :sign_in_count
      field :last_sign_in_at
    end
  end

end