class ArticlesController < ApplicationController
  skip_before_filter :authorize
  load_and_authorize_resource only: [:index, :show], find_by: :permalink
  load_resource only: [:calendar]
  respond_to :html, :js, :json


  def calendar
    authorize! :calendar, Article
    @articles = @articles.published
    @articles_by_date = @articles.group_by { |article| article.published_at.to_date }
    @date = params[:date] ? Date.parse(params[:date]) : Time.zone.now.to_date
  end

  def index
    @articles = @articles.basic_search(params[:query]) if params[:query].present?
    @articles = @articles.page(params[:page]).per(params[:per_page])
  end

  def show
    @root_comments = @article.comments.includes(:user).roots
  end

  def tags
    authorize! :tag_search, Article
    @articles_tag_counts = Article.published.tag_counts
    unless params[:tag].blank?
      @articles = Article.published.tagged_with(params[:tag])
      @articles = @articles.basic_search(params[:query]) if params[:query].present?
      @articles = @articles.page(params[:page]).per(params[:per_page])
    else
      redirect_to root_url
    end
  end

  def tag_search
    authorize! :tag_search, Article
    if params[:query].present?
      @tags = ActsAsTaggableOn::Tag.tag_search(params[:query])
      @tags = @tags.page(params[:page]).per(params[:per_page])
    end
  end

  def typeahead_search
    @articles = Article.published.typeahead_search(params[:query])
    render json: @articles.to_pretty_json
  end

end
