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

      def uptoken
        # put_policy = Qiniu::Auth::PutPolicy.new(
        #   "hanks",                    # 存储空间
        #   nil,                           # 最终资源名，可省略，即缺省为“创建”语义
        #   1800,                          # 相对有效期，可省略，缺省为3600秒后 uptoken 过期
        #   (Time.now + 30.minutes).to_i  # 绝对有效期，可省略，指明 uptoken 过期期限（绝对值），通常用于调试，这里表示半小时
        # )
        # uptoken = Qiniu::Auth.generate_uptoken(put_policy) #生成凭证
      end
  end
end
