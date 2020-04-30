module Admin::Plant
  extend ActiveSupport::Concern
  include Admin::Shared::Address

  included do
    rails_admin do
      field :name
      field :supplier do
        inline_add false
        inline_edit false
      end
      field :city do
        inline_add false
        inline_edit false
      end
      field :delivery_radius
      field :address

      show do
        field :latitude
        field :longitude

        field :location_details, :json

        field :map_link do
          pretty_value do
            %{<a target="blank" href="#{value}">#{value}</a>}.html_safe
          end
        end
      end

      edit do
        field :latitude
        field :longitude
      end

      list do
        field :location

        field :map_link do
          pretty_value do
            %{<a target="blank" href="#{value}">link</a>}.html_safe
          end
        end
      end
    end

    _validators.reject!{ |key, _| key == :latitude }
    _validators.reject!{ |key, _| key == :longitude }

  end

  def address
    self.address_full
  end

  def address=(value)
    @address = value
  end

  def admin_display_name
    "#{self.name}"
  end

  def map_link
    "https://www.google.com/maps/place/?q=place_id:#{self.address_id}"
  end

end

