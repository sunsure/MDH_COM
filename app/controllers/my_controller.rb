class MyController < ApplicationController
  def dashboard
    @show_sidebar_carousel = true
    @dashboard_boxes = Dashboard.boxes_for(current_user)
  end
end
