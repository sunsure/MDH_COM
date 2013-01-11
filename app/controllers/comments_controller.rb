class CommentsController < ApplicationController
  load_and_authorize_resource :article, find_by: :permalink
  load_and_authorize_resource :comment, through: :article, except: [:create]
  authorize_resource :comment, only: [:create]
  respond_to :js#, :html

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
    @comment.update_attributes(safe_params)
  end

  private

  def safe_params
    safe_attributes = [
      :content
    ]
    params.require(:comment).permit(*safe_attributes)
  end
end
