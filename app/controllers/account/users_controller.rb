module Account
  require 'mini_magick'
  class UsersController < Account::AccountController
    load_and_authorize_resource

    def index
      cookies[:sidebar_active] = "users"
      @users = @users.paginate(:page => params[:page])
    end

    def show
      cookies[:sidebar_active] = "users-show"
    end

    def new
    end

    def edit
    end

    def create
      if @user.save
        redirect_to action: :index
      else
        render :new
      end
    end

    def edit_password
      @resource = @user
      @resource_name = :user
    end

    def edit_head
    end

    def update
      if params[:avatar_file].present?
        @user.head_avatar = params[:avatar_file]
        if @user.save
          img = MiniMagick::Image.open(@user.head_avatar.current_path)
          avatar_data = eval(params[:avatar_data])
          crop_params="#{avatar_data[:width]}x#{avatar_data[:height]}+#{avatar_data[:x]}+#{avatar_data[:y]}"
          rotate_size = avatar_data[:rotate]
          img.rotate(rotate_size)
          img.crop(crop_params)
          img.write @user.head_avatar.current_path
          render :json => {result: true, url: @user.head_avatar.url}.to_json
        else
          render :json => {result: false, message: "图片上传失败，请重新上传"}.to_json
        end
      else
        if @user.update(user_params)
          redirect_to ({action: :show}.merge(id: @user.id))
        else
          render :edit
        end
      end
    end

    def destroy
      @user.destroy
      redirect_to action: :index
    end

    private
      def user_params
        params.require(:user).permit(:title, :content, :user_id, :nickname, :head_avatar)
      end
  end
end