module Admin::ProductStrength
  extend ActiveSupport::Concern

  included do
    rails_admin do
      field :product do
        inline_add false
        inline_edit false
      end
      field :name
      field :group
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
    return "" unless product.present?
    "#{product.name}: #{self.name}"
  end

end
