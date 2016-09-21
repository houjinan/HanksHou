module Account
  class LabelsController < Account::AccountController
    load_and_authorize_resource
    def index
      @labels = Label.all.paginate(:per_page => 20, :page => params[:page])
    end


    def edit
      @label = Label.find(params[:id])
    end

    def update
      @label = Label.find params[:id]
      if @label.update(label_params)
        redirect_to action: :index
      else
        render :edit
      end
    end

    def destroy
      @label = Label.find(params[:id])
      if @label.articles.present?
        flash[:error] = "标签存在已经使用的文章不能删除！"
      else
        flash[:notice] = "删除成功！"
        @label.destroy
      end
      redirect_to action: :index
    end


    private
      def label_params
        params.require(:label).permit(:name)
      end
  end

end