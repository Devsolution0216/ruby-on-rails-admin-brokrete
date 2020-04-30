module Admin::PlantAvailabilityTime
  extend ActiveSupport::Concern

  included do
    rails_admin do
      field :plant do
        inline_add false
        inline_edit false
      end
      field :status
      field :value
    end
  end
end
