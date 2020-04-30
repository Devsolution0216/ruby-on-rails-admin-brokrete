module Admin::Country
  extend ActiveSupport::Concern

  included do
    rails_admin do
      field :name

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
    "#{self.name}"
  end

end

