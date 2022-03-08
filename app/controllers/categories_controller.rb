class CategoriesController < ApplicationController

  before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5) # pagination
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Catergory was created successfully"
      redirect_to @category
    else
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.paginate(page: params[:page], per_page: 5) # this will help grab @articles instance variable in the category show view
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "Category name updated successfully"
      redirect_to categories_path
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin)
      flash[:alert] = "Only admins can perform that action"
      redirect_to categories_path
    end
  end
end