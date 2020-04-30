module Admin::OrderOption
  extend ActiveSupport::Concern

  included do
    rails_admin do
      field :order do
        inline_add false
        inline_edit false
      end

      field :option do
        inline_add false
        inline_edit false
      end

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

end
