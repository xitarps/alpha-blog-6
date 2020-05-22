class ArticlesController < ApplicationController
  before_action :set_article, only: %i|show edit update destroy|

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    msg = 'saved successfully'
    return redirect_to @article, notice: msg.to_s if @article.save
    render :new
  end

  def edit
  end

  def update
    msg = 'saved successfully'
    return redirect_to @article, notice: msg.to_s if @article.user == current_user && @article.update(article_params)
    render :edit
  end

  def destroy
    @articles = Article.all
    @article.delete if @article.user == current_user
    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
