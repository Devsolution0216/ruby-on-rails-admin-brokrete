module Admin::Config
  extend ActiveSupport::Concern

  included do
    rails_admin do
      field :supplier do
        inline_add false
        inline_edit false
      end

      field :plant do
        inline_add false
        inline_edit false
      end

      field :city do
        inline_add false
        inline_edit false
      end

      field :type

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
      end
    end
  end

  def admin_display_name
    "#{self.type}"
  end

end
