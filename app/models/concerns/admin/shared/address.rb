module Admin::Shared::Address
  extend ActiveSupport::Concern

  included do
    skip_callback :validation, :before, :validate_address
    before_validation :admin_validate_address
  end

  class_methods do
  end

  def admin_validate_address

    puts "Try to validate address: #{@address}"

    if @address.present? && @address != self.address_full
      coords = Geokit::Geocoders::GoogleGeocoder.geocode(@address,
        components: {
          administrative_area: self.city.name,
          country: self.city.country.name
        },
        result_type: "street_address|route|political|locality",
        location_type: "ROOFTOP")

      update_address! nil

      self.address_full = @address

      if coords.success && coords.precision == "building" && coords.street_name.present?

        self.latitude = coords.lat
        self.longitude = coords.lng

        if self.respond_to? :city
          unless coords.city == self.city.name
            errors.add(:error, "Wrong city at [#{self.latitude}, #{self.longitude}]: expected #{self.city.name}, got #{coords.city}")
          end
        end

        update_address! coords

      else
        errors.add(:error, "Wrong address: #{@address}")
      end
    else
      validate_address
    end

  end

  def address
    self.address_full
  end

  def address=(value)
    @address = value
  end
end
