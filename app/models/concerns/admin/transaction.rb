module Admin::Transaction
  extend ActiveSupport::Concern

  included do
    rails_admin do
      field :id do
        filterable false
        sortable false
      end
      field :contractor do
        inline_add false
        inline_edit false
      end
      field :provider do
        column_width 100
      end
      field :type do
        column_width 100
      end
      field :currency do
        column_width 100
      end
      field :__amount do
        column_width 100
      end
      field :status do
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
      end

      edit do
        field :created_at do
          hide
        end
      end

    end
  end

  def admin_display_name
    "#{self.provider} - #{self.type}"
  end

  def __amount
    self.amount
  end

  def __amount=(value)
    self.amount = value
  end
end
