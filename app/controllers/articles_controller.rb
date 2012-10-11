class ArticlesController < ApplicationController
  skip_before_filter :authorize, only: [:index, :show]
  respond_to :html

  load_and_authorize_resource only: [:index, :new]
  load_resource only: :show
  load_resource only: [:edit, :update, :destroy], through: :current_user
  authorize_resource only: [:create, :edit, :update, :destroy, :show]

  def index
  end

  def show
  end

  def new
  end

  def edit
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
    if @article.update_attributes(safe_params)
      redirect_to @article, notice: t('articles.controller.update.success')
    else
      flash[:error] =  t('articles.controller.update.failure')
      render :edit
    end
  end

  def destroy
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
