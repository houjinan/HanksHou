module CanCan
  class ControllerResource
    def self.add_before_action_with_set_resource_user(controller_class, method, *args)
      add_before_action_without_set_resource_user(controller_class, method, *args)
      controller_class.send(:before_action, :set_resource_user)
    end

    class << self
      alias_method_chain(:add_before_action, :set_resource_user)
    end

    # def initialize_with_set_resources(controller, *args)
    #   initialize_without_set_resources(controller, *args)
    #   controller.add_cancan_resource(self.name)

    # end
    # alias_method_chain(:initialize, :set_resources)
  end

end