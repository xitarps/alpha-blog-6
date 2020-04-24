class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    msg = 'saved successfully'
    return redirect_to @article, notice: msg.to_s if @article.save
    render :new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    msg = 'saved successfully'
    @article = Article.find(params[:id])
    return redirect_to @article, notice: msg.to_s if @article.update(article_params)
    render :edit
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
