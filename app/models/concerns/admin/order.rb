module Admin::Order
  extend ActiveSupport::Concern
  include Admin::Shared::Address

  included do
    rails_admin do
      field :product do
        inline_add false
        inline_edit false
      end
      field :product_strength do
        inline_add false
        inline_edit false
      end
      field :product_decorate do
        inline_add false
        inline_edit false
      end
      field :city do
        inline_add false
        inline_edit false
      end
      field :plant do
        inline_add false
        inline_edit false
      end
      field :__quantity
      field :__total_price
      field :status, :active_record_enum

      field :__trucks

      field :time_between_trucks, :enum do
        enum do
          [0,15,30,45]
        end
        default_value 15
      end
      field :delivery_time

      field :address

      show do
        field :latitude
        field :longitude
        field :location_details, :json
        field :created_at
        field :details, :json
      end

      edit do
        field :latitude
        field :longitude
        field :created_at do
          hide
        end
        field :__quantity do
          hide
        end
        field :__total_price do
          hide
        end
      end

      list do
        field :location

        field :created_at do
          column_width 180
          sort_reverse true
        end

        sort_by :created_at
      end
    end

    _validators.reject!{ |key, _| key == :latitude }
    _validators.reject!{ |key, _| key == :longitude }
  end

  def __trucks
    self.trucks.join(" - ")
  rescue
    self.trucks
  end

  def __trucks=(value)
    if !value.nil? && value.is_a?(::String)
      self.trucks = (value.split("-").map(&:to_f))
    else
      self.trucks = value
    end
  end

  def __total_price
    self.total_price
  end

  def __quantity
    self.quantity
  end
end
