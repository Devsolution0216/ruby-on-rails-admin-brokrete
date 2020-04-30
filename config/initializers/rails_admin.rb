RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except [
        "Contractor",
        "ContractorIdentity",
        "Transaction",
        "AccountTransaction",
        "Order",
        "OrderOption",
        "User"
      ]
    end
    # export
    # bulk_delete
    show
    edit do
      except [
        "AccountTransaction",
        "Transaction"
      ]
    end
    delete
    # show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.label_methods = [:admin_display_name]

  config.default_hidden_fields = {
    list: [:created_at, :updated_at],
    show: [:created_at, :updated_at],
    edit: [:id, :created_at, :updated_at]
  }

  config.total_columns_width = 9999999
  config.sidescroll = {num_frozen_columns: 0}
end
