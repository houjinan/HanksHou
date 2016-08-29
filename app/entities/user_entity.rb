class UserEntity < Grape::Entity
  expose :id, documentation: {required: true, type: "String", desc: "user id"} do |instance, options|
    instance.id.to_s
  end
  expose :email, documentation: {required: true, type: "String", desc: "user email"}
  expose :auth_token,    documentation: {required: true, type: "String"}, if: {return_token: true} do |instance, options|
    instance.auth_tokens.try(:first).try(:token_value)
  end
end