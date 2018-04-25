class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  before_action :require_admin, only: [:new, :create]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category was created successfully"
      redirect_to categories_path
    else
      render "new"
    end
  end

  def show
    #@category_articles = Article.find([category_id: @category.id]).paginate(page: params[:page], per_page: 5)
  end
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
  
  def set_category
    @category = Category.find(params[:id])
  end
    
  def require_admin
    if !logged_in? || (logged_in? && !current_user.admin?)
      flash[:danger] = "Only admin users can perform this action"
      redirect_to root_path
    end
  end
  
end