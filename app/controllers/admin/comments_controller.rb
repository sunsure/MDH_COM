class Admin::CommentsController < AdminController
  load_and_authorize_resource :article, find_by: :permalink
  load_and_authorize_resource :comment, through: :article
  respond_to :js#, :html

  def destroy
    @comment.destroy
    flash.now[:notice] = t('admin.comments.controller.destroy.success')
  end

end
