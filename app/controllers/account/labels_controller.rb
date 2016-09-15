module Account
  class LabelsController < Account::AccountController
    def index
      @labels = Label.all.paginate(:per_page => 20, :page => params[:page])
    end


    def edit
      @label = Label.find(params[:id])
    end

    def update

    end

    def destroy
      @label = Label.find(params[:id])
      if @label.articles.present?
        flash[:error] = "exist label's articles" 
      else
        @label.destroy
      end
      redirect_to :index
    end
  end

end