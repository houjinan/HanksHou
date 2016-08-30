class V1::UsersApi < Grape::API


  resource :users do

    desc "注册用户", {
      entity: UserEntity
    }
    params do
      requires :email, type: String, allow_blank: false, regexp: /.+@.+/
      requires :password, type: String
    end

    post "sign_up" do
      user = User.create email: params[:email], password: params[:password]
      error! user.errors.full_messages.join(","), 400 unless user.persisted?
      user.auth_tokens.create
      present user, with: UserEntity, return_token: true
    end


    desc "用户登录", {
      entity: UserEntity
    }
    params do
      requires :email, type: String, allow_blank: false, regexp: /.+@.+/
      requires :password, type: String
    end

    get "sign_in" do
      user = User.where(email: params[:email]).first
      error! "invalid_mobile_number_or_password", 401 unless user
      res = user.valid_password?(params[:password])
      error! "invalid_mobile_number_or_password", 401 unless res
      user.auth_tokens.create unless user.auth_tokens.any?
      present user, with: UserEntity, return_token: true
    end
  end
end