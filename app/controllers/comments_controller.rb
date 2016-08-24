class CommentsController < ApplicationController
  before_action :set_comment, only: [:destory]

  def new
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to controller: :articles, action: :show, id: @comment.article_id }
        format.js   { }
        format.json { render :show, status: :created, location: @comment }
      else
        @msg = @comment.errors.full_messages.join('<br />')
        format.html { render :new }
        format.js   { }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
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
