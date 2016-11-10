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
        @uptoken = uptoken
        filePath = params[:avatar].path
        key = params[:avatar].original_filename
        # 调用 upload_with_token_2 方法上传
        code, result, response_headers = Qiniu::Storage.upload_with_token_2(
             @uptoken,
             filePath,
             key,
             nil, # 可以接受一个 Hash 作为自定义变量，请参照 http://developer.qiniu.com/article/kodo/kodo-developer/up/vars.html#xvar
             bucket: "hanks"
        )
        binding.pry
        if code == 200
          @human.update(avatar: result[:hash])
        end
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
