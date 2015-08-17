module ConsolidatedOrders
  class Railtie < Rails::Railtie
    initializer "my_railtie.configure_rails_initialization" do |app|
      FeatureBase.register(app, ConsolidatedOrders)
      FeatureBase.register_autoload_path(app, "consolidated_orders")
    end
    config.after_initialize do
      FeatureBase.inject_feature_record("Consolidated Orders",
        "ConsolidatedOrders",
        "This will give the site the ability order products in bulk by setting up consolidated orders."
      )
      FeatureBase.inject_permission_records(
        ConsolidatedOrders,
        RestrictCatalogFeatureDefinition.new.permissions
      )
    end
  end
end
