module Admin::OrderPrice
  extend ActiveSupport::Concern

  included do
    rails_admin do
      field :order do
        inline_add false
        inline_edit false
      end

      field :product_strength_price do
        inline_add false
        inline_edit false
      end

      field :product_decorate_price do
        inline_add false
        inline_edit false
      end

      field :__value

      field :created_at do
        sort_reverse true
      end

      list do
        sort_by :created_at
      end

      edit do
        field :created_at do
          hide
        end

        field :__value do
          hide
        end
      end
    end
  end

  def __value
    self.value
  end

  def __value=(value)
    self.value = value
  end
end
