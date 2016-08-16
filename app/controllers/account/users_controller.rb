module Account
  require 'mini_magick'
  class UsersController < Account::AccountController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
      @users = User.desc(:created_at)
      cookies[:sidebar_active] = "users"
      @users = @users.paginate(:per_page => 10, :page => params[:page])
    end

    def show
      cookies[:sidebar_active] = "users-show"
      @user = User.find(params[:id])
    end

    def new
      @user = User.new
    end

    def edit
      @user = User.find(params[:id])
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to action: :index
      else
        render :new
      end
    end

    def edit_password
      @user = User.find(params[:id])
      @resource = @user
      @resource_name = :user
    end

    def edit_head
      @user = User.find(params[:id])
    end

    def update
      if params[:avatar_file].present?
        @user.head_avatar = params[:avatar_file]
        if @user.save
          img = MiniMagick::Image.open(@user.head_avatar.current_path)
          avatar_data = eval(params[:avatar_data])
          crop_params="#{avatar_data[:width]}x#{avatar_data[:height]}+#{avatar_data[:x]}+#{avatar_data[:y]}"
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
      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:title, :content, :user_id, :nickname, :head_avatar)
      end
  end
end