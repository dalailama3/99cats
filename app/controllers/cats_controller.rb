class CatsController < ApplicationController
  before_action :require_user, only: [:new, :create, :edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])

    render :show

  end

  def create
    @cat = current_user.cats.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end


  def update
    @cat = current_user.cats.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  def edit
    @cat = current_user.cats.find(params[:id])
    render :edit
  end

  def new
    @cat = Cat.new
    render :new
  end

  def destroy
    @cat = Cat.find(params[:id])
    @cat.destroy

    redirect_to cats_url
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :color, :birth_date, :description, :sex)

  end
end
