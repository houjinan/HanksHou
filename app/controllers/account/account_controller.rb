module Account
  class AccountController < ApplicationController

    before_action :authenticate_user!
    layout 'account_layout'

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to account_unauthorized_error_path
    end

    def add_cancan_resource resource_name
      @cancan_resource = resource_name
    end

    private

      def set_resource_user
        return unless ["new", "create"].include?(action_name)
        resource_record = instance_variable_get("@#{controller_name.singularize}")
        if resource_record.present? && resource_record.attribute_names.include?("user_id")
          resource_record.user = current_user
        end
      end
  end
end
