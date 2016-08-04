class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :vote, :collection]
  protect_from_forgery :except => :preview
  def index
    @articles = Article.where(is_public: true).desc("created_at")
    if params[:label_id].present?
      @articles = Label.find(params[:label_id]).articles
    end
    if params[:search].present?
      @articles = @articles.any_of({:title => Regexp.new(".*"+params[:search]+".*")}, {:content => Regexp.new(".*"+params[:search]+".*") })
    end

    @type = params[:type].present? ? params[:type] : Article.default_type
    @articles = @articles.where(article_type: @type).paginate(:per_page => 10, :page => params[:page])
    @labels = @articles.map(&:labels).flatten.compact.uniq

    cookies["nav_active"] = @type
    # render component: 'Articles', props: { todos: @articles }, tag: 'span', class: 'article' and return
  end

  def show
    @article.visit_count = @article.visit_count + 1
    @article.save
    @type = @article.article_type
    @labels = @article.try(&:labels).flatten.compact.uniq
  end

  def vote
    @article.vote_users << current_user if current_user.present?
    redirect_to ({action: :show}.merge(id: @article.id))
  end

  def collection
    @article.collection_users << current_user if current_user.present?
    redirect_to ({action: :show}.merge(id: @article.id))
  end

  def preview
    out = MarkdownTopicConverter.convert(params[:body])
    render plain: out
    # @body = params[:body]
    # respond_to do |format|
    #   format.json
    # end
  end
  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :user_id)
    end
end
