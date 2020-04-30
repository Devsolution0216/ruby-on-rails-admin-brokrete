module Admin::Contractor
  extend ActiveSupport::Concern

  included do
    rails_admin do
      field :id do
        filterable false
        sortable false
      end

      field :name
      field :type do
        column_width 100
      end
      field :company_name do
        column_width 120
      end
      field :identities do
        column_width 300
      end
      field :account do
        inline_add true
        inline_edit true
        column_width 100
      end
      field :created_at do
        column_width 200
        sort_reverse true
      end

      list do
        sort_by :created_at
      end

      show do
        field :details, :json
        field :id
      end

      edit do
        field :created_at do
          hide
        end
        field :id do
          hide
        end
      end
    end
  end

  def admin_display_name
    "#{self.name} - #{self.company_name}"
  end

end
