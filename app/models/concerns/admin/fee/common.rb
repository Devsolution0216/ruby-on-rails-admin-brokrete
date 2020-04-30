module Admin::Fee::Common
  extend ActiveSupport::Concern

  included do
    rails_admin do
      field :name
      field :display_name

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

      show do
        field :details, :json
      end
    end
  end

  def admin_display_name
    "#{self.name}"
  end

end
