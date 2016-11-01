require "consolidated_orders/version"

module ConsolidatedOrders

  # This will be executed in the ability class, by defalut, if the Feature is enabled.
  class Default
    def self.permissions
      ["can_view_consolidated_orders"]
    end
  end

  class ConsolidatedOrdersFeatureDefinition
    include FeatureSystem::Provides
    def permissions
      [
        {
          can: true,
          callback_name: 'can_view_consolidated_orders',
          name: 'Can View Consolidated Orders'
        },
        {
          can: true,
          callback_name: 'can_manage_consolidated_orders',
          name: 'Can Manage All Consolidated Orders'
        }
      ]
    end
  end

  module Authorization
    module Permissions

      def can_manage_consolidated_orders
        can :manage, ConsolidatedOrder
      end

      def can_view_consolidated_orders
        cannot :read, ConsolidatedOrder

        accessible_co_ids = @user.consolidated_orders.pluck(:id)

        can :read, ConsolidatedOrder, status: [0], id: accessible_co_ids
        can :view, ConsolidatedOrder, status: [0], id: accessible_co_ids
      end

    end
  end
end
require 'consolidated_orders/railtie' if defined?(Rails)
