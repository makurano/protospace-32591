class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :prevent_edit, only: [:edit, :update, :destroy]
  def index
    @prototypes = Prototype.all
    # binding.pry
  end
  
  def new
    @prototype = Prototype.new
  end
  
  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
      redirect_to prototype_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    if prototype.destroy
      redirect_to "/"
    else
      render :show
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def prevent_edit
    unless Prototype.find(params[:id]).user_id == current_user.id
      redirect_to action: :show  
    end
  end

end
