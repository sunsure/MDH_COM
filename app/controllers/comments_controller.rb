class CommentsController < ApplicationController
  load_and_authorize_resource :article, find_by: :permalink
  load_and_authorize_resource :comment, through: :article, except: [:create]
  authorize_resource :comment, only: [:create]
  respond_to :js

  def new
  end

  def edit
    respond_with @comment
  end

  def create
    @comment = @article.comments.create!(safe_params.merge!(user: current_user))
  end

  def update
    @comment.update_attributes(safe_params)
  end

  def destroy
    @comment.destroy

    redirect_to articles_url
  end

  private

  def safe_params
    safe_attributes = [
      :content
    ]
    params.require(:comment).permit(*safe_attributes)
  end
end
