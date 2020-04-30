module Admin::Account
  extend ActiveSupport::Concern

  included do
    rails_admin do
      field :name
      field :contractor
      field :__credit
      field :__balance
      field :credit_expired_at

      field :created_at do
        column_width 200
        sort_reverse true
      end

      edit do

        field :name do
          hide
        end

        field :contractor do
          hide
        end

        field :created_at do
          hide
        end

        field :__balance do
          hide
        end
      end

      list do
        sort_by :created_at
      end
    end
  end

  def admin_display_name
    "#{self.name}: #{self.contractor&.admin_display_name}"
  end

  def __credit
    self.credit
  end

  def __credit=(value)
    self.credit = value
  end

  def __balance
    self.balance
  end

end
