module Admin::AccountTransaction
  extend ActiveSupport::Concern

  included do
    rails_admin do
      field :id
      field :account
      field :payment_transaction
      field :type
      field :created_at do
        column_width 200
        sort_reverse true
      end

      list do
        sort_by :created_at
        field :id do
          hide
        end
      end
    end
  end

end
