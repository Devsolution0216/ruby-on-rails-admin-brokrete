module Admin::Product
  extend ActiveSupport::Concern

  included do
    rails_admin do
      field :name
      field :service_key
      field :units
      field :sort_order

      field :created_at

      list do
        sort_by :sort_order
        field :image do
          pretty_value do
            bindings[:view].tag(:img, { src: bindings[:object].image, height: 60 })
          end
        end
      end

      edit do
        field :created_at do
          hide
        end
        field :image
      end

      show do
        field :details, :json
        field :image do
          pretty_value do
            bindings[:view].tag(:img, { src: bindings[:object].image, height: 60 })
          end
        end
      end
    end
  end

  def admin_display_name
    "#{self.name}"
  end

end
