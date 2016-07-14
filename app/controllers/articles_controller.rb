class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  def index
    @articles = Article.desc("created_at")
    if params[:label_id].present? 
      @articles = Label.find(params[:label_id]).articles
    end
    if params[:search].present?
      @articles = @articles.any_of({:title => Regexp.new(".*"+params[:search]+".*")}, {:content => Regexp.new(".*"+params[:search]+".*") })
    end
    @articles = @articles.paginate(:per_page => 10, :page => params[:page])
    @labels = @articles.map(&:labels).flatten.compact.uniq

    # render component: 'Articles', props: { todos: @articles }, tag: 'span', class: 'article' and return 
  end

  def show
    @article.visit_count = @article.visit_count + 1
    @article.save
    @labels = Article.all.map(&:labels).flatten.compact.uniq
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :user_id)
    end
end
