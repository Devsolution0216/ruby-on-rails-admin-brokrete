module Admin::ContractorIdentity
  extend ActiveSupport::Concern

  included do
    rails_admin do

      field :contractor

      field :provider do
        column_width 100
      end

      field :uid

      field :confirmed, :boolean do
        column_width 50
      end

      field :created_at do
        column_width 200
        sort_reverse true
      end

      list do
        sort_by :created_at
      end

      edit do
        configure :provider do
          read_only true
        end

        configure :uid do
          read_only true
        end

        exclude_fields :contractor
      end

    end
  end

  def admin_display_name
    "[#{self.provider}] #{uid}"
  end

  def confirmed
    self.confirmed?
  end

  def confirmed=(value)
    value = ActiveRecord::Type::Boolean.new.cast(value)

    self.confirm if value
    self.reset_confirm unless value
  end
end
