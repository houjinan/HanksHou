class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :vote, :collection, :delete_vote, :delete_collection]
  before_action :authenticate_user!, only: [:vote, :collection, :delete_collection]
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
  end

  def show
    @article.visit_count = @article.visit_count + 1
    @article.save
    @type = @article.article_type
    @labels = @article.try(&:labels).flatten.compact.uniq
    Notification.where(notify_type: 'comment', user: current_user).each{|n| n.update(read_at: DateTime.now) if n.target.article == @article}
  end

  def vote
    if @article.vote_users.include?(current_user)
      @msg = "您已经点赞!"
    else
      @article.vote_users << current_user
      @msg = "点赞成功!"
    end
    respond_to do |format|
      format.html { redirect_to ({action: :show}.merge(id: @article.id))}
      format.js   { }
    end
  end

  def collection
    if @article.vote_users.include?(current_user)
      @msg = "您已经收藏!"
    else
      @article.collection_users << current_user
      @msg = "收藏成功!"
    end
    respond_to do |format|
      format.html { redirect_to ({action: :show}.merge(id: @article.id))}
      format.js   { }
    end
  end

  def delete_collection
    current_user.collection_articles = current_user.collection_articles - [@article]
    redirect_to :back
  end

  def preview
    # out = MarkdownTopicConverter.convert(params[:body])
    # render plain: out
    @body = params[:body]
    respond_to do |format|
      format.json
    end
  end
  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :user_id)
    end
end
