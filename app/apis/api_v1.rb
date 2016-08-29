class ApiV1 < Grape::API
  format :json
  version :v1
  prefix :api

  before do
    I18n.locale = params[:locale] || "zh-CN"
  end

  get do
    { version: 'v1'}
  end


  mount V1::UsersApi
  mount V1::ArticlesApi

  add_swagger_documentation doc_version: 'v1'
end