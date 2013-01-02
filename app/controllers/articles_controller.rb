class ArticlesController < ApplicationController
  skip_before_filter :authorize, only: [:index, :show, :tags, :calendar]
  load_and_authorize_resource only: [:index, :show], find_by: :permalink
  load_resource only: [:calendar]
  respond_to :html


  def calendar
    authorize! :calendar, Article
    @articles = @articles.published
    @articles_by_date = @articles.group_by { |article| article.published_at.to_date }
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def index
    @articles = @articles.page(params[:page]).per(params[:per_page])
  end

  def show
    if request.get? && params[:comment].present?
      flash[:notice] = 'Stubbed'
      redirect_to @article
    end
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
