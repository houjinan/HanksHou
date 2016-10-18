module Account
  class HumenController < Account::AccountController
    load_and_authorize_resource
    def index
      @humen = @humen.paginate(:page => params[:page])
      cookies[:sidebar_active] = "human"
    end

    def show
    end

    def new
    end

    def graphic

    end

    def edit
    end

    def create
      if @human.save
        flash[:notice] = '创建成功'
        redirect_to ({action: :show}.merge(id: @human.id))
      else
        render :new
      end
    end

    def update
      if @human.update(human_params)
        flash[:notice] = '成功更新'
        redirect_to ({action: :show}.merge(id: @human.id))
      else
        render :edit
      end
    end

    def destroy
      if @human.destroy
        flash[:notice] = '成功删除'
        redirect_to action: :index
      else
        flash[:error] = '删除失败'
        redirect_to action: :index
      end
    end

    private
      def human_params
        params.require(:human).permit(:realname, :birthday, :sex, :work)
      end
  end
end
