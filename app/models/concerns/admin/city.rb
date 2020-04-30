module Admin::City
  extend ActiveSupport::Concern

  included do
    rails_admin do
      field :name
      field :country do
        inline_add false
        inline_edit false
      end

      show do
        field :location

        field :location_details, :json

        field :map_link do
          pretty_value do
            %{<a target="blank" href="#{value}">#{value}</a>}.html_safe
          end
        end
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
  end

  def admin_display_name
    return "" unless country.present?
    "#{self.name}, #{country.name}"
  end

  def map_link
    "https://www.google.com/maps/place/?q=place_id:#{self.address_id}"
  end

end
