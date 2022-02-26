class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    # @articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 5) # pagination
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params_article)
    @article.user = User.first # temporary hard coded user
    if @article.save
      flash[:notice] = "Article was saved successfully"
      redirect_to @article
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(params_article)
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end


  private

  def params_article
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end

 #byebug --> use to pause program to verify values are being passed at each stage of execution
 #render plain: params[:article]  Displays the form params in plain text.