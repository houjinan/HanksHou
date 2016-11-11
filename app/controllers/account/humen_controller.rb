module Account
  class HumenController < Account::AccountController
    load_and_authorize_resource
    def index
      @humen = @humen.paginate(:page => params[:page])
      cookies[:sidebar_active] = "human"
    end

    def show
      primitive_url = 'http://7xkefc.com1.z0.glb.clouddn.com/Head.png'
      @download_url = Qiniu::Auth.authorize_download_url(primitive_url)
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
        key = File.basename(params[:avatar].original_filename, ".*") + @human.id + @human.class.to_s + File.extname(params[:avatar].original_filename)
        # 调用 upload_with_token_2 方法上传
        code, result, response_headers = Qiniu::Storage.upload_with_token_2(@uptoken, filePath, key, nil, bucket: "hanks")
        if code == 200
          @human.update(avatar: result["key"])
        end
        flash[:notice] = '创建成功'
        redirect_to action: :index
      else
        render :new
      end
    end

    def update
      if @human.update(human_params)
        @uptoken = uptoken
        filePath = params[:avatar].path
        key = File.basename(params[:avatar].original_filename, ".*") + @human.id + @human.class.to_s + File.extname(params[:avatar].original_filename)
        # 调用 upload_with_token_2 方法上传
        code, result, response_headers = Qiniu::Storage.upload_with_token_2(@uptoken, filePath, key, nil, bucket: "hanks")
        if code == 200
          @human.update(avatar: result["key"])
        end
        flash[:notice] = '成功更新'
        redirect_to action: :index
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
