class ArticlesController < ApplicationController
  skip_before_filter :authorize, only: [:index, :show]
  respond_to :html
  authorize_resource except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = current_user.articles.find(params[:id])
  end

  def create
    @article = current_user.articles.new(safe_params)

    if @article.save
      redirect_to @article, notice: t('articles.controller.create.success')
    else
      flash[:error] = t('articles.controller.create.failure')
      render :new
    end
  end

  def update
    @article = current_user.articles.find(params[:id])

    if @article.update_attributes(safe_params)
      redirect_to @article, notice: t('articles.controller.update.success')
    else
      flash[:error] =  t('articles.controller.update.failure')
      render :edit
    end
  end

  def destroy
    @article = current_user.articles.find(params[:id])
    if @article.destroy
      flash[:notice] = t('articles.controller.destroy.success')
    else
      flash[:notice] = t('articles.controller.destroy.failure')
    end
    redirect_to articles_url
  end

  private

  def safe_params
    safe_attributes = [
      :content,
      :title,
      :publish
    ]
    params.require(:article).permit(*safe_attributes)
  end

end
