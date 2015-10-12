module Account
  class ArticlesController < AccountController
    before_action :authenticate_user!
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    def index
      @articles = current_user.articles.paginate(:per_page => 10, :page => params[:page])
    end

    def show
    end

    def new
      @article = current_user.articles.new
    end

    def edit
      @article = Article.find(params[:id])
    end

    def create
      @article = current_user.articles.new(article_params)      
      if @article.save
        redirect_to action: :index
      else
        render :new
      end
    end

    def update
      if @article.update(article_params)
        redirect_to action: :index
      else
        render :edit
      end
    end

    def destroy
      @article.destroy
      redirect_to action: :index
    end

    private
      def set_article
        @article = Article.find(params[:id])
      end

      def article_params
        params.require(:article).permit(:title, :content, :user_id)
      end
  end
end