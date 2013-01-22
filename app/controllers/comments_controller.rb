class CommentsController < ApplicationController
  load_and_authorize_resource :article, find_by: :permalink
  load_and_authorize_resource :comment, through: :article, except: [:create]
  authorize_resource :comment, only: [:create, :new_reply, :reply]
  respond_to :js

  def new
  end

  def edit
    respond_with @comment
  end

  def create
    @comment = @article.comments.new(safe_params.merge!(user: current_user))
    if @comment.save
      flash.now[:notice] = t('comments.controller.create.success')
    else
      flash.now[:error] = t('comments.controller.create.failure')
    end
  end

  def update
    if @comment.update_attributes(safe_params)
      flash.now[:notice] = t('comments.controller.update.success')
    else
      flash.now[:error] = t('comments.controller.update.failure')
    end
  end

  # GET
  def new_reply
    # send back an AJAX response so we can reply to the proper parent comment
    @article = Article.find_by_permalink!(params[:article_id])
    @parent_comment = @article.comments.find(params[:id])
    @comment = @article.comments.new(parent_id: @parent_comment.id)
  end

  # POST
  def reply
    # actually try to create the nested comment
    @article = Article.find_by_permalink!(params[:article_id])
    @parent_comment = @article.comments.find(params[:id])
    @comment = @article.comments.new(safe_params.merge!(parent_id: @parent_comment.id, user: current_user))
    if @comment.save
      flash.now[:notice] = t('comments.controller.reply.success')
    else
      flash.now[:error] = t('comments.controller.reply.failure')
    end
  end

  private

  def safe_params
    safe_attributes = [
      :content,
      :title,
      :parent_id,
    ]
    params.require(:comment).permit(*safe_attributes)
  end
end
