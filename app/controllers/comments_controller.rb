class CommentsController < ApplicationController
  before_action :set_comment, only: [:destory]

  def new
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to controller: :articles, action: :show, id: @comment.article_id
    else

    end

  end

  def destory

  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content, :article_id)
    end
end
