class Admin::CommentsController < AdminController
  load_and_authorize_resource :article, find_by: :permalink
  load_and_authorize_resource :comment, through: :article
  respond_to :js

  def destroy
    if @comment.destroy
      flash.now[:notice] = t('admin.comments.controller.destroy.success')
    else
      flash.now[:error] = t('admin.comments.controller.destroy.failure')
    end
  end

end
