ActiveSupport.on_load(:active_record) do
  (ActiveRecord::Base.connection.tables - %w[schema_migrations]).each do |table|
    table.classify.constantize rescue nil
  end

  ApplicationRecord.subclasses.map do |constant|
    result = [constant]

    inheritance_types = constant.defined_enums[constant.inheritance_column]&.keys

    if inheritance_types.present?
      result << inheritance_types.map { |type| constant.find_sti_class(type)}
    end

    result
  end.flatten.each do |constant|
    concern_class_name = "Admin::#{constant.name}"

    begin
      concern_class_name.constantize
      concern_class = Module.const_get concern_class_name
      constant.class_eval do
        include concern_class
      end

      RailsAdmin.config.included_models << constant
    rescue
      puts "No Admin module: #{concern_class_name}"
    end
  end

end
