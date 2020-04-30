module Admin::Option
  extend ActiveSupport::Concern

  included do
    rails_admin do
      field :name
      field :sort_order
      field :created_at

      list do
        sort_by :sort_order
      end

      edit do
        field :created_at do
          hide
        end
      end

      show do
        field :details, :json
      end
    end
  end

  def admin_display_name
    "#{self.name}"
  end

end
