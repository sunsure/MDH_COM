class Admin::ArticlesController < ApplicationController
  skip_before_filter :authorize, only: [:index, :show, :tags]
  respond_to :html

  load_and_authorize_resource only: [:index, :new], find_by: :permalink
  load_resource only: :show, find_by: :permalink
  load_resource only: [:edit, :update, :destroy], through: :current_user, find_by: :permalink
  authorize_resource only: [:create, :edit, :update, :destroy, :show]

  def index
    @articles = @articles.page(params[:page]).per(params[:per_page])
    render layout: "admin"
  end

  def show
    render layout: "admin"
  end

  def new
    render layout: "admin"
  end

  def edit
    render layout: "admin"
  end

  def create
    @article = current_user.articles.new(safe_params)

    if @article.save
      redirect_to @article, notice: t('admin.articles.controller.create.success')
    else
      flash[:error] = t('admin.articles.controller.create.failure')
      render :new
    end
  end

  def update
    if @article.update_attributes(safe_params)
      redirect_to articles_url, notice: t('admin.articles.controller.update.success')
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
    redirect_to articles_url
  end

  def tags
    authorize! :tag_search, Article
    unless params[:tag].blank?
      @articles = Article.tagged_with(params[:tag]).page(params[:page]).per(params[:per_page])
    else
      redirect_to root_path
    end
  end

  private

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
