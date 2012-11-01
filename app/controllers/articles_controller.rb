class ArticlesController < ApplicationController
  skip_before_filter :authorize, only: [:index, :show]
  load_and_authorize_resource only: [:index, :show]
  respond_to :html


  def index
    @articles = @articles.page(params[:page]).per(params[:per_page])
  end

  def show
  end

end
