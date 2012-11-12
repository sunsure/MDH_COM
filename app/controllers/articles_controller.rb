class ArticlesController < ApplicationController
  skip_before_filter :authorize, only: [:index, :show, :tags]
  load_and_authorize_resource only: [:index, :show], find_by: :permalink
  respond_to :html


  def index
    @articles = @articles.page(params[:page]).per(params[:per_page])
  end

  def show
  end

  def tags
    authorize! :tag_search, Article
    unless params[:tag].blank?
      @articles = Article.tagged_with(params[:tag]).page(params[:page]).per(params[:per_page])
    else
      redirect_to root_path
    end
  end

end
