module Admin::PlantProduct
  extend ActiveSupport::Concern

  included do
    rails_admin do
      field :plant do
        inline_add false
        inline_edit false
      end

      field :product do
        inline_add false
        inline_edit false
      end

      field :product_decorate do
        inline_add false
        inline_edit false
      end

      field :product_strength do
        inline_add false
        inline_edit false
      end

      field :active

      list do
        field :product do
          hide
        end
      end
    end
  end

end
