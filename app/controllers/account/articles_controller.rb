module Account
  class ArticlesController < Account::AccountController
    # before_action :authenticate_user!
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    def index
      @type = params[:type].present? ? params[:type] : Article.default_type
      cookies[:sidebar_active] = @type
      @articles = current_user.articles.where(article_type: @type).desc("created_at").paginate(:per_page => 10, :page => params[:page])
    end

    def collections
      cookies[:sidebar_active] = "collection"
      @articles = current_user.collection_articles.desc("created_at").paginate(:per_page => 10, :page => params[:page])
    end

    def show
    end

    def new
      @type = params[:type].present? ? params[:type] : Article.default_type
      @article = current_user.articles.new(article_type: @type)
    end

    def edit
      @article = Article.find(params[:id])
    end

    def create
      labels = params.delete(:labels).to_s
      @article = current_user.articles.new(article_params)
      if @article.save
        initialize_or_create_labels(labels)
        redirect_to ({action: :index}.merge(type: @article.article_type))
      else
        render :new
      end
    end

    def update

      @article = Article.find params[:id]

      labels = params.delete(:labels).to_s
      initialize_or_create_labels(labels)
      if @article.update(article_params)
        redirect_to ({action: :index}.merge(type: @article.article_type))
      else
        render :edit
      end
    end

    def destroy
      @article.destroy
      redirect_to action: :index
    end

    private
      def initialize_or_create_labels(labels)
        @article.labels = []
        labels.split(",").each do |name|
          label = Label.find_or_initialize_by(name: name.strip)
          label.save!
          @article.labels << label
        end
      end
      def set_article
        @article = Article.find(params[:id])
      end

      def article_params
        params.require(:article).permit(:title, :content, :article_type, :is_public, :user_id)
      end
  end
end