module Account
  class UsersController < Account::AccountController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
      @users = User.desc(:created_at)
      @users = @users.paginate(:per_page => 10, :page => params[:page])
    end

    def show
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
      if @user.update(user_params)
        redirect_to ({action: :show}.merge(id: @user.id))
      else
        render :edit
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