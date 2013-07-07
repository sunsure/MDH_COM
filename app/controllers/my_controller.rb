class MyController < ApplicationController

  def comments
    authorize! :read, Comment
    # Show the comments where the current_user is the AUTHOR of the comment
    @comments = current_user.my_comments.includes(:article)
    @comments = @comments.page(params[:page]).per(params[:per_page])
  end

  def dashboard
    @show_sidebar_carousel = true
    @dashboard_boxes = Dashboard.boxes_for(current_user)
  end

end
