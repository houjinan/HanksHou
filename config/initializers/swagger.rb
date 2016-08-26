GrapeSwaggerRails.options.url      = "/api/v1/swagger_doc"

GrapeSwaggerRails.options.before_filter_proc = proc {
  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
}

GrapeSwaggerRails.options.app_name = 'HanksHou Apis'


# GrapeSwaggerRails.options.app_url  = 'http://localhost:3300'
# GrapeSwaggerRails.options.api_auth     = 'basic'
# GrapeSwaggerRails.options.api_key_name = 'Authorization'
# GrapeSwaggerRails.options.api_key_type = 'header'