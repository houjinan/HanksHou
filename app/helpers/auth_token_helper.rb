module AuthTokenHelper

  def token_authenticate!
    error!("4010", 401) if params[:auth_token].nil?
    error!('4014', 401) unless api_user
  end

  def api_user
    @api_user ||= AuthToken.where(token_value: params[:auth_token]).first.try(:user)
  end

end
