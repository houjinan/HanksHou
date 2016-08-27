GrapeSwaggerRails.options.url      = "/api/v1/swagger_doc"

GrapeSwaggerRails.options.before_filter_proc = proc {
  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
}

GrapeSwaggerRails.options.app_name = 'HanksHou Apis'


GrapeSwaggerRails.options.before_filter do |request|
  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
  if current_user.blank? || !current_user.is_super_admin?
    request.session[:user_return_to] = request.url
    redirect_to "/users/sign_in"
  end 
end

# GrapeSwaggerRails.options.app_url  = 'http://localhost:3300'
# GrapeSwaggerRails.options.api_auth     = 'basic'
# GrapeSwaggerRails.options.api_key_name = 'Authorization'
# GrapeSwaggerRails.options.api_key_type = 'header'