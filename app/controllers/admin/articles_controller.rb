class Admin::ArticlesController < AdminController
  respond_to :html, :js

  load_and_authorize_resource only: [:index, :new], find_by: :permalink
  load_resource only: [:show, :calendar], find_by: :permalink
  load_resource only: [:edit, :update, :destroy], through: :current_user, find_by: :permalink
  authorize_resource only: [:create, :edit, :update, :destroy, :show]

  def calendar
    authorize! :calendar, Article
    @articles = @articles.published
    @articles_by_date = @articles.group_by { |article| article.published_at.to_date }
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def index
    handle_published
    @articles = @articles.page(params[:page]).per(params[:per_page])
  end

  def show
    @root_comments = @article.comments.includes(:user).roots
  end

  def new
  end

  def edit
  end

  def create
    @article = current_user.articles.new(safe_params)

    if @article.save
      redirect_to admin_article_url(@article), notice: t('admin.articles.controller.create.success')
    else
      flash[:error] = t('admin.articles.controller.create.failure')
      render :new
    end
  end

  def update
    if @article.update_attributes(safe_params)
      redirect_to admin_article_url(@article), notice: t('admin.articles.controller.update.success')
    else
      flash[:error] =  t('admin.articles.controller.update.failure')
      render :edit
    end
  end

  def destroy
    if @article.destroy
      flash[:notice] = t('admin.articles.controller.destroy.success')
    else
      flash[:notice] = t('admin.articles.controller.destroy.failure')
    end

    # do stuff depending on the request type
    respond_to do |format|
      format.html { redirect_to admin_articles_url }
      format.js
    end
  end

  def tags
    authorize! :tag_search, Article
    unless params[:tag].blank?
      @articles = Article.tagged_with(params[:tag]).page(params[:page]).per(params[:per_page])
    else
      redirect_to root_url
    end
  end

  private

  def handle_published
    if params[:published].present?
      case params[:published]
      when 'true'
        @articles = @articles.published
      when 'false'
        @articles = @articles.draft
      end
    end
  end

  def safe_params
    safe_attributes = [
      :content,
      :excerpt,
      :permalink,
      :publish,
      :published_at,
      :title,
      :tag_list,
    ]
    params.require(:article).permit(*safe_attributes)
  end

end
