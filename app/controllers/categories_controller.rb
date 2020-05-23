class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5).order('created_at DESC')
  end

  def new
    @category = Category.new()
  end

  def create
    @category = Category.new(category_params)
    return redirect_to @category, notice: 'Category was successfully created' if @category.save
    render :new
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
  
  def require_admin
    if !logged_in? || (logged_in? and !current_user.admin?)
      flash[:alert] = 'Only admins allowed to do that...'
      redirect_to categories_path 
    end
  end
end