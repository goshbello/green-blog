class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article]  This displays the form params in plain text. Just to check if form data is submit and all is working okay
    @article = Article.new(params_article)
    if @article.save
      flash[:notice] = "Article was saved successfully"
      redirect_to @article
    else
      render :new
    end
  end

  def show
    #byebug --> use to pause program to verify what values are being passed at each stage
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(params_article)
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end


  private

  def params_article
    params.require(:article).permit(:title, :description)
  end


end