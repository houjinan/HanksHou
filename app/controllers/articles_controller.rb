class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  def index
    @articles = Article.desc("created_at").paginate(:per_page => 10, :page => params[:page])
    if params[:label_id].present? 
      @articles = Label.find(params[:label_id]).articles
    end
    @articles = @articles.paginate(:per_page => 10, :page => params[:page])
    @labels = Label.all
  end

  def show
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :user_id)
    end
end
