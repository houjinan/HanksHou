module Account
  class ArticlesController < Account::AccountController
    load_and_authorize_resource

    def index
      @type = params[:type].present? ? params[:type] : Article.default_type
      cookies[:sidebar_active] = @type
      @articles = current_user.articles.where(article_type: @type).paginate(:page => params[:page])
    end

    def collections
      cookies[:sidebar_active] = "collection"
      @articles = current_user.collection_articles.desc("created_at").paginate(:page => params[:page])
    end

    def new
      @type = params[:type].present? ? params[:type] : Article.default_type
      @article.article_type =  @type
    end

    def edit
    end

    def create
      labels = params[:labels].to_s
      if @article.save
        initialize_or_create_labels(labels)
        redirect_to ({action: :index}.merge(type: @article.article_type))
      else
        render :new
      end
    end

    def update
      labels = params.delete(:labels).to_s
      initialize_or_create_labels(labels)
      if @article.update(article_params)
        redirect_to ({action: :index}.merge(type: @article.article_type))
      else
        render :edit
      end
    end

    def destroy
      type = @article.article_type
      @article.destroy
      redirect_to ({action: :index}.merge(type: type))
    end

    def calendar
      data = current_user.calendar_data
      render json: data
    end

    private
      def initialize_or_create_labels(labels)
        @article.labels = []
        labels.split(",").each do |name|
          next if name.blank?
          label = Label.find_or_initialize_by(name: name.strip)
          label.save!
          @article.labels << label
        end
      end

      def article_params
        params.require(:article).permit(:title, :content, :article_type, :is_public, :user_id)
      end
  end
end