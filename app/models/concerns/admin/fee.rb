module Admin::Fee
  extend ActiveSupport::Concern

  included do
    rails_admin do
      field :name
      field :display_name

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
        field :details, :json
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
